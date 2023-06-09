import matplotlib.pyplot as plt
import tensorflow as tf
from tensorflow.keras.preprocessing.image import load_img, img_to_array
from sklearn.metrics import confusion_matrix
import os
import cv2
import numpy as np
from tqdm import tqdm
from flask import jsonify, flash, redirect, url_for
from pathlib import Path

from get_load_data import GetLoadData
from data_preprocess import DataProcessing


list_folder = ['Training', 'Testing']

class TrainPred:

    def __init__(self, batch_size=32):
        self.batch_size = batch_size
        self.list_class = ['Diamond', 'Oblong', 'Oval', 'Round', 'Square', 'Triangle']
        self.face_crop_img = True
        self.face_landmark_img = True
        self.landmark_extraction_img = True

        self.prepro_img = 0
        self.prepro_img2 = 0
        self.name = ""
        self.progres = 0

        self.data_processor = DataProcessing()

    def train_model(self, model, train_generator, test_generator, epoch):
        model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])
        history = model.fit(train_generator, epochs=epoch, validation_data=test_generator)
        return history

    def prediction(self, model):
        img_width, img_height = 224, 224
        img = load_img("./static/result_upload2.jpg", target_size=(img_width, img_height))
        img = img_to_array(img)
        img = img/255.0
        img = np.expand_dims(img, axis=0)
        pred = model.predict(img)
        pred_2 = model.predict_on_batch(img)
        print(f"Pred :{pred}")
        print(f"Pred 2 : {pred_2}")

        # menghitung softmax
        softmax_pred = np.exp(pred) / np.sum(np.exp(pred), axis=1, keepdims=True)

        # print(softmax_pred)
        max_value = int(round(np.max(softmax_pred * 100)))
        # print(max_value)

        pred = np.argmax(pred, axis=1)

        # Map the label
        pred = [self.list_class[k] for k in pred]

        return pred, max_value

    def plot_accuracy(self, result, epoch):
        train_acc_gr = result.history['accuracy']
        val_acc_gr = result.history['val_accuracy']
        epochs = range(1, epoch+1)

        # Plot training accuracy
        plt.plot(epochs, train_acc_gr, label='Training Accuracy')
        plt.plot(epochs, val_acc_gr, label='Testing Accuracy')

        # Set plot title and labels
        plt.title('Model Accuracy')
        plt.xlabel('Epoch')
        plt.ylabel('Accuracy')
        plt.legend(loc='best')

        # Save plot as image file
        plt.savefig('./static/accuracy_plot.png')
        # plt.show()
        plt.close()

    def plot_loss(self, result, epoch):
        train_loss_gr = result.history['loss']
        val_loss_gr = result.history['val_loss']
        epochs = range(1, epoch+1)

        # Plot training accuracy
        plt.plot(epochs, train_loss_gr, label='Training Loss')
        plt.plot(epochs, val_loss_gr, label='Testing Loss')

        # Set plot title and labels
        plt.title('Model Loss')
        plt.xlabel('Epoch')
        plt.ylabel('Loss')
        plt.legend(loc='best')

        # Save plot as image file
        plt.savefig('./static/loss_plot.png')
        # plt.show()
        plt.close()

    def plot_confusion_matrix(self, model, test_generator):
        # Get the predictions from the model
        predictions = model.predict(test_generator, steps=len(test_generator), verbose=1)
        y_pred = np.argmax(predictions, axis=1)
        y_true = test_generator.classes

        # Generate confusion matrix
        cm = confusion_matrix(y_true, y_pred)

        # Plot the confusion matrix
        fig, ax = plt.subplots(figsize=(8, 8))
        ax.imshow(cm, cmap='Blues')
        ax.set_title('Confusion Matrix')
        ax.set_xlabel('Predicted Labels')
        ax.set_ylabel('True Labels')
        ax.set_xticks(range(len(test_generator.class_indices)))
        ax.set_xticklabels(test_generator.class_indices.keys(), rotation=90)
        ax.set_yticks(range(len(test_generator.class_indices)))
        ax.set_yticklabels(test_generator.class_indices.keys())
        for i in range(len(test_generator.class_indices)):
            for j in range(len(test_generator.class_indices)):
                ax.text(j, i, str(cm[i, j]), ha='center', va='center', color='white')
        fig.tight_layout()

        filename = './static/confusion_matrix.png'
        # Save the confusion matrix as an image file
        fig.savefig(filename)

        return filename

    def data_configuration(self, train_image_df, test_image_df):
        train_datagen = tf.keras.preprocessing.image.ImageDataGenerator(rescale=1./255)
        test_datagen = tf.keras.preprocessing.image.ImageDataGenerator(rescale=1./255)

        train_generator = train_datagen.flow_from_dataframe(
            dataframe=train_image_df,
            x_col='Filepath',
            y_col='Label',
            target_size=(220, 280),
            color_mode='rgb',
            class_mode='categorical',
            batch_size=self.batch_size,
            subset='training'
        )

        test_generator = test_datagen.flow_from_dataframe(
            dataframe=test_image_df,
            x_col='Filepath',
            y_col='Label',
            target_size=(220, 280),
            color_mode='rgb',
            class_mode='categorical',
            batch_size=self.batch_size,
            subset='training'
        )

        return train_generator, test_generator

    def model_architecture(self):
        model = tf.keras.models.Sequential()

        # layers from the previous code
        model.add(tf.keras.layers.Conv2D(64, (3, 3), activation='relu', input_shape=(220, 280, 3)))
        model.add(tf.keras.layers.Conv2D(64, (3, 3), activation='relu'))
        model.add(tf.keras.layers.MaxPooling2D((2, 2)))
        model.add(tf.keras.layers.Conv2D(128, (3, 3), activation='relu'))
        model.add(tf.keras.layers.Conv2D(128, (3, 3), activation='relu'))
        model.add(tf.keras.layers.MaxPooling2D((2, 2)))
        model.add(tf.keras.layers.Conv2D(256, (3, 3), activation='relu'))
        model.add(tf.keras.layers.Conv2D(256, (3, 3), activation='relu'))
        model.add(tf.keras.layers.MaxPooling2D((2, 2)))

        model.add(tf.keras.layers.Flatten())
        model.add(tf.keras.layers.Dense(6, activation='softmax'))

        model.summary()

        return model

    # @staticmethod
    def do_pre1(self,test):
        global prepro_img
        global face_landmark_img, landmark_extraction_img
        self.prepro_img = 0
        try:
            if (self.face_landmark_img == True):
                GetLoadData.folder_maker("Face Landmark")

                for i in tqdm(range(0, len(list_folder)), desc=f"Processing {list_folder} images"):
                    for j in range(0, len(self.list_class)):
                        dataset = f"./static/dataset/Face Shape/{list_folder[i]}/{self.list_class[j]}"
                        len_dataset = os.listdir(f"./static/dataset/Face Shape/{list_folder[i]}/{self.list_class[j]}")
                        image_dir = Path(dataset)
                        for k in (range(0, len(len_dataset))):
                            filepaths, labels = GetLoadData.load_image_data(image_dir)
                            img = cv2.imread(filepaths[k])
                            img = self.data_processor.annotate_face_mesh(image=img)
                            # print("./static/dataset/Face Landmark/" + f"{list_folder[i]}/" + f"{list_class[j]}/" + f"{len_dataset[k]}")
                            cv2.imwrite(
                                "./static/dataset/Face Landmark/" + f"{list_folder[i]}/" + f"{self.list_class[j]}/" + f"{len_dataset[k]}",
                                img)
                            self.prepro_img += 1

                return jsonify({'message': 'Preprocessing 1 sukses'}), 200

        except Exception as e:
            flash('Terjadi error: {}'.format(str(e)))

        return redirect(url_for('index'))

    def do_pre2(self,test):
        global prepro_img2
        global face_landmark_img, landmark_extraction_img
        self.prepro_img2 = 0
        try:
            if (self.landmark_extraction_img == True):
                GetLoadData.folder_maker("Landmark Extraction")
                for i2 in tqdm(range(0, len(list_folder)), desc=f"Processing {list_folder} images"):
                    for j2 in range(0, len(self.list_class)):
                        new_dataset = f"./static/dataset/Face Landmark/{list_folder[i2]}/{self.list_class[j2]}"
                        len_new_dataset = os.listdir(
                            f"./static/dataset/Face Landmark/{list_folder[i2]}/{self.list_class[j2]}")

                        image_dir = Path(new_dataset)
                        for k in (range(0, len(len_new_dataset))):
                            filepaths, labels = GetLoadData.load_image_data(image_dir)
                            img = cv2.imread(filepaths[k])

                            subtracted_img = np.zeros(img.shape, np.uint8)

                            # ----------------------------------------------------------------------
                            img1 = cv2.imread(
                                f'./static/dataset/Face Landmark/{list_folder[i2]}/{self.list_class[j2]}/{len_new_dataset[k]}')
                            img2 = cv2.imread(
                                f'./static/dataset/Face Shape/{list_folder[i2]}/{self.list_class[j2]}/{len_new_dataset[k]}')

                            # Lakukan perhitungan pengurangan pixel secara manual
                            for l in range(img1.shape[0]):
                                for m in range(img1.shape[1]):
                                    subtracted_img[l, m] = abs(int(img1[l, m][0]) - int(img2[l, m][0]))

                            # ----------------------------------------------------------------------
                            cv2.imwrite(
                                "./static/dataset/Landmark Extraction/" + f"{list_folder[i2]}/" + f"{self.list_class[j2]}/" + f"{len_new_dataset[k]}",
                                subtracted_img)
                            self.prepro_img2 += 1

                            # requests.get(url_for('get_progress_1', _external=True), params={'progress': prepro_img2})

                # prepro_img = 0
                # code preprocessing
                return jsonify({'message': 'Preprocessing sukses'}), 200
        except Exception as e:
            flash('Terjadi error: {}'.format(str(e)))
        return redirect(url_for('index'))

    def get_progress_1(self):

        if self.prepro_img > 0:
            self.name = "Face Landmark"
            self.progres = self.prepro_img
            print(self.progres)

        if self.prepro_img2 > 0:
            self.name = "Landmark Extraction"
            self.progres = self.prepro_img2
            print(self.progres)

        return self.progres, self.name


