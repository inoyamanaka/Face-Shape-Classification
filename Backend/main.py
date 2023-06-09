import shutil
import cv2
import mediapipe as mp
from werkzeug.utils import secure_filename
import tensorflow as tf
import os
from flask import Flask, jsonify, request, flash, redirect, url_for


#-----------------------------------------------------
app = Flask(__name__, template_folder='./templates')
#-----------------------------------------------------


#-----------------------------------------------------
# Tempat deklarasi variabel-variabel penting
filepath = ""
list_class = ['Diamond','Oblong','Oval','Round','Square','Triangle']
list_folder = ['Training', 'Testing']
face_crop_img = True
face_landmark_img = True
landmark_extraction_img = True
#-----------------------------------------------------


#-----------------------------------------------------
# Tempat deklarasi model dan sejenisnya
selected_model = tf.keras.models.load_model(f'models/model_checkpoint.h5', compile=False)
face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_alt2.xml')
mp_drawing = mp.solutions.drawing_utils
mp_face_mesh = mp.solutions.face_mesh
drawing_spec = mp_drawing.DrawingSpec(thickness=1, circle_radius=1)
#-----------------------------------------------------


#-----------------------------------------------------
# Tempat setting server
UPLOAD_FOLDER = './upload'
UPLOAD_MODEL = './models'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg','zip','h5'}
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['UPLOAD_MODEL'] = UPLOAD_MODEL
app.config['MAX_CONTENT_LENGTH'] = 500 * 1024 * 1024  # 500 MB
#-----------------------------------------------------

epoch = 3
batch_size = 16
optimizer = "adam"

prepro_img = 0
prepro_img2 = 0
name = ""
progres = 0

from file_processing import FileProcess
from get_load_data import GetLoadData
from data_preprocess import DataProcessing
from train_pred import TrainPred

#-----------------------------------------------------

data_processor = DataProcessing()
data_train_pred = TrainPred()

import random
def preprocessing(filepath):
    print("deck2")
    folder_path = './static/temporary'  # Ganti dengan path folder yang sesuai

    # # Menghapus semua isi folder
    # os.mkdir(folder_path)
    shutil.rmtree(folder_path)
    os.mkdir(folder_path)

    print("deck3")
    data_processor.detect_landmark(data_processor.face_cropping_pred(filepath))

    files = os.listdir(folder_path)
    index = 0
    for file_name in files:
        # Mendapatkan ekstensi file
        file_ext = os.path.splitext(file_name)[1]
        # Membuat nama file acak dengan urutan bilangan acak dari 1-100000
        new_file_name = str(index) + "_" + str(random.randint(1, 100000)) + file_ext
        # Rename file
        os.rename(os.path.join(folder_path, file_name), os.path.join(folder_path, new_file_name))
        index += 1

    print("Tungu sampai selesaiii")

train_datagen = tf.keras.preprocessing.image.ImageDataGenerator(rescale=1 / 255.)
test_datagen = tf.keras.preprocessing.image.ImageDataGenerator(rescale=1 / 255.)

#-----------------------------------------------------

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/selected_models', methods=['POST'])
def select_models():
    global selected_model
    data = request.form.get('index')
    if data is not None:
        data = int(data)
    # index = data.get('index')
    print(data)
    selected_model = tf.keras.models.load_model(f'models/fc_model_{data}.h5')

    # Lakukan sesuatu dengan indeks yang diterima
    return jsonify({'message': 'Request berhasil diterima'})

@app.route('/count_models')
def get_models():
    folder_path = './models/'  # ganti dengan path folder yang ingin dihitung
    files = os.listdir(folder_path)
    count = len(files)
    print(count)
    return jsonify({'count': count})

@app.route('/delete_img')
def delete_img():
    for i in range (0,4):
        if os.path.exists(f"./static/result_upload{i}.jpg"):
            os.remove(f"./static/result_upload{i}.jpg")
            print("File terhapus")
            return jsonify({'message': 'Berhasil di hapus'}), 400
        else:
            print("File tidak ditemukan.")
            return jsonify({'message': 'No file selected for uploading'}), 400

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({'message': 'No file part in the request'}), 400

    file = request.files['file']

    if file.filename == '':
        return jsonify({'message': 'No file selected for uploading'}), 400

    filename = secure_filename(file.filename)
    filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    file.save(filepath)
    img = cv2.imread(filepath)
    # Detect Face
    try:
        print("deck")
        preprocessing(img)
        return jsonify({'message': 'File successfully uploaded'})
    except:
        path = "empty_image.png"
        return jsonify({'message': 'File failed to uploaded'})

    return jsonify({'message': 'File successfully uploaded'})

@app.route('/upload_data', methods=['POST'])
def upload_data():
    if 'file' not in request.files:
        return jsonify({'message': 'No file part in the request'}), 400

    file = request.files['file']

    if file.filename == '':
        return jsonify({'message': 'No file selected for uploading'}), 400

    if file and FileProcess.allowed_file(file.filename):
        filename = secure_filename(file.filename)
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(filepath)

        FileProcess.extract_zip(filepath)
        return jsonify({'message': 'File successfully uploaded'})

    return jsonify({'message': 'File failed to uploaded'})


@app.route('/upload_model', methods=['POST'])
def upload_model():
    if 'file' not in request.files:
        return jsonify({'message': 'No file part in the request'}), 400

    file = request.files['file']

    if file.filename == '':
        return jsonify({'message': 'No file selected for uploading'}), 400

    if file and FileProcess.allowed_file(file.filename):
        filename = secure_filename(file.filename)
        filepath = os.path.join(app.config['UPLOAD_MODEL'], filename)
        file.save(filepath)

        return jsonify({'message': 'File successfully uploaded'})

    return jsonify({'message': 'File failed to uploaded'})

@app.route('/get_total_files')
def get_total_files():
    training_counts = GetLoadData.get_training_file_counts()
    testing_counts = GetLoadData.get_testing_file_counts()
    result = {}
    result['training'] = training_counts.json
    result['testing'] = testing_counts.json
    return jsonify(result)

@app.route('/get_images')
def get_images():
    folder_path = "./static/temporary/"
    files = [f for f in os.listdir(folder_path) if os.path.isfile(os.path.join(folder_path, f))]
    urls = []
    for i in range(0, 4):
        # Mendapatkan daftar nama semua file di dalam folder

        url = f'{public_url}/static/temporary/{files[i]}'

        urls.append(url)

        bentuk, persentase = data_train_pred.prediction(selected_model)
        print("apakah ini bentuk wajah : ",bentuk[0])
        print("apakah ini persentase : ", persentase)
        print(urls)

    return jsonify({'urls': urls, 'bentuk wajah':bentuk[0], 'persen':persentase})

@app.route('/get_random_images_crop')
def get_random_images_crop():
    images = GetLoadData.get_random_images("Face Crop")
    return jsonify({'random_images': images})

@app.route('/get_random_images_landmark')
def get_random_images_landmark():
    images = GetLoadData.get_random_images("Face Landmark")
    return jsonify({'random_images': images})

@app.route('/get_random_images_extract')
def get_random_images_extract():
    images = GetLoadData.get_random_images("landmark Extraction")
    return jsonify({'random_images': images})

@app.route('/face_cropping', methods=['POST'])
def face_cropping():
    global face_crop_img
    status = request.form.get('status')
    # Lakukan sesuatu dengan nilai status yang diterima
    print(f"face _cropping : {status}")
    face_crop_img = status
    return face_crop_img

@app.route('/facial_landmark', methods=['POST'])
def facial_landmark():
    global face_landmark_img
    status = request.form.get('status')
    # Lakukan sesuatu dengan nilai status yang diterima
    print(f"facial_landmark : {status}")
    face_landmark_img = status
    return face_landmark_img

@app.route('/landmark_extraction', methods=['POST'])
def landmark_extraction():
    global landmark_extraction_img
    status = request.form.get('status')
    # Lakukan sesuatu dengan nilai status yang diterima
    print(f"Landmark_extraction : {status}")
    landmark_extraction_img = status
    return landmark_extraction_img

@app.route('/progress', methods=['GET'])
def get_progress():
    global progres, name
    progres, name = data_train_pred.get_progress_1()

    return jsonify({'progress': progres, 'name': name})
    # return jsonify({'message': 'Request berhasil diterima'})

@app.route('/progress2', methods=['GET'])
def get_progress_2():
    global prepro_img
    return jsonify({'progress': prepro_img, 'name': "Landmark Extraction"})

@app.route('/do_preprocessing')
def do_preprocessing():
    global prepro_img, prepro_img2
    global face_landmark_img, landmark_extraction_img

    prepro_img = 0
    prepro_img2 = 0

    data_train_pred.do_pre1(test="")
    data_train_pred.do_pre2(test="")

    print("selesaii")

    # code preprocessing
    return jsonify({'message': 'Preprocessing sukses'})


@app.route('/dropdown', methods=['POST'])
def handle_dropdown():
    global optimizer
    dropdown_value = request.form['value']
    optimizer = dropdown_value
    # Lakukan apa yang perlu dilakukan dengan nilai dropdown di sini
    print(f"optimizers : {optimizer}")
    return jsonify({'success': True})

@app.route('/textfield', methods=['POST'])
def handle_textfield():
    global epoch
    textfield_value = request.form['value']
    epoch = int(textfield_value)
    print(f"epoch : {epoch}")
    # Lakukan apa yang perlu dilakukan dengan nilai textfield di sini
    return jsonify({'success': True})

@app.route('/textfield2', methods=['POST'])
def handle_textfield2():
    global batch_size
    textfield_value = request.form['value']
    batch_size = int(textfield_value)
    print(f"batch_size : {batch_size}")
    # Lakukan apa yang perlu dilakukan dengan nilai textfield di sini
    return jsonify({'success': True})

@app.route('/getinfo', methods=['GET'])
def get_info_prepro():
    global optimizer, epoch, batch_size
    print(optimizer)
    result1 = f"Fungsi Aktivasi : {optimizer}"
    result2 = f"Jumlah Epoch : {epoch}"
    result3 = f"Batch Size : {batch_size}"

    return jsonify(result1,result2,result3)


import matplotlib.pyplot as plt
@app.route('/do_training')
def do_training():
    global epoch
    folder = ""
    if os.path.exists("./static"):
        files = ["accuracy_plot.png", "confusion_matrix.png", "loss_plot.png"]  # ganti dengan nama file yang ingin dihapus
        files_to_delete = [f for f in files if os.path.exists(os.path.join("./static", f))]
        if files_to_delete:
            print("Files to delete:")
            for file_to_delete in files_to_delete:
                file_path = os.path.join("./static", file_to_delete)
                print(file_path)
                os.remove(file_path)
            print("Files deleted!")
        else:
            print("No files to delete.")

    if (face_landmark_img == True and landmark_extraction_img == True):
        folder = "Landmark Extraction"
    elif (face_landmark_img == True and landmark_extraction_img == False):
        folder = "Face Landmark"
    # --------------------------------------------------------------
    train_dataset_path = f"./static/dataset/{folder}/Training/"
    test_dataset_path = f"./static/dataset/{folder}/Testing/"

    train_image_df, test_image_df = GetLoadData.load_image_dataset(train_dataset_path, test_dataset_path)

    train_gen, test_gen = data_train_pred.data_configuration(train_image_df, test_image_df)
    model = data_train_pred.model_architecture()

    result = data_train_pred.train_model(model, train_gen, test_gen, epoch)

    # Mengambil nilai akurasi training dan validation dari objek result
    train_acc = result.history['accuracy'][-1]
    val_acc = result.history['val_accuracy'][-1]

    # Plot accuracy
    data_train_pred.plot_accuracy(result=result, epoch=epoch)

    path_image = 'accuracy_plot.png'
    acc_url = f'{public_url}/static/{path_image}'

    # Plot loss
    data_train_pred.plot_loss(result=result, epoch=epoch)

    path_image_2 = 'loss_plot.png'
    loss_url = f'{public_url}/static/{path_image_2}'


    data_train_pred.plot_confusion_matrix(model, test_gen)
    conf = "confusion_matrix.png"
    conf_url = f'{public_url}/static/{conf}'

    # Mengembalikan respons HTTP dalam format JSON yang berisi nilai akurasi
    epoch = 3
    return jsonify({'train_acc': train_acc, 'val_acc': val_acc, 'plot_acc': acc_url,'plot_loss': loss_url, 'conf': conf_url})
    # return jsonify({'train_acc': train_acc, 'val_acc': val_acc})

@app.route('/total_models')
def total_models():
    folder_path = "./models/"  # ganti dengan path folder yang ingin dihitung jumlah filenya
    num_files = len([f for f in os.listdir(folder_path) if os.path.isfile(os.path.join(folder_path, f))])

    print("Jumlah file dalam folder adalah:", num_files)


if __name__ == '__main__':

    # public_url = ngrok.connect(8080).public_url
    # public_url = "http://192.168.100.243:8080"
    public_url = "https://yamanaka1.pagekite.me"

    # hotspot hp
    # public_url = "http://192.168.45.79:8080"
    print(f' * Running on {public_url}')

    # Menjalankan aplikasi Flask
    # app.run(host="192.168.100.243", port=8080, use_reloader=True)

    # hotspot hp
    # app.run(host="192.168.45.79", port=8080, use_reloader=True)
    app.run(port=1000, use_reloader=True)
    # app.run(port=8080)

# py pagekite.py 1000 yamanaka1.pagekite.me
