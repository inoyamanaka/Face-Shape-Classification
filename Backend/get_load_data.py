import os
import random
import pandas as pd
from pathlib import Path
from flask import jsonify

list_class = ['Diamond','Oblong','Oval','Round','Square','Triangle']

public_url = "https://yamanaka1.pagekite.me"

class GetLoadData:
    @staticmethod
    def get_training_file_counts():
        path = "./static/dataset/Face Shape"
        training_file_counts = []

        # Loop melalui folder Training
        for sub_folder in ["Diamond", "Oblong", "Oval", "Round", "Square", "Triangle"]:
            # Tentukan path ke folder sub_folder dalam folder Training
            sub_path = os.path.join(path, "Training", sub_folder)

            # Gunakan fungsi listdir untuk membaca semua file dalam folder sub_folder
            num_files = len([f for f in os.listdir(sub_path) if os.path.isfile(os.path.join(sub_path, f))])

            # Tambahkan jumlah file ke dalam array training_file_counts
            training_file_counts.append(num_files)

        total_file = sum(training_file_counts)
        training_file_counts.append(total_file)

        # Return hasil dalam bentuk JSON
        return jsonify(training_file_counts)

    @staticmethod
    def get_testing_file_counts():
        path = "./static/dataset/Face Shape"
        testing_file_counts = []

        # Loop melalui folder Testing
        for sub_folder in ["Diamond", "Oblong", "Oval", "Round", "Square", "Triangle"]:
            # Tentukan path ke folder sub_folder dalam folder Testing
            sub_path = os.path.join(path, "Testing", sub_folder)

            # Gunakan fungsi listdir untuk membaca semua file dalam folder sub_folder
            num_files = len([f for f in os.listdir(sub_path) if os.path.isfile(os.path.join(sub_path, f))])

            # Tambahkan jumlah file ke dalam array testing_file_counts
            testing_file_counts.append(num_files)

        total_file = sum(testing_file_counts)
        testing_file_counts.append(total_file)

        # Return hasil dalam bentuk JSON
        return jsonify(testing_file_counts)

    @staticmethod
    def folder_maker(preprocessing_name):
        folder_path = f'./static/dataset/{preprocessing_name}'
        training_path = f'./static/dataset/{preprocessing_name}/Training'
        testing_path = f'./static/dataset/{preprocessing_name}/Testing'

        # Membuat folder dataset/Landmark Face Shape jika belum ada
        if not os.path.exists(folder_path):
            os.makedirs(folder_path)

            # Membuat folder dataset/Landmark Face Shape/Training jika belum ada
            if not os.path.exists(training_path):
                os.makedirs(training_path)
                for i in range(0, len(list_class)):
                    os.mkdir(f'{training_path}/{list_class[i]}')

        # Membuat folder dataset/Landmark Face Shape/Testing jika belum ada
        if not os.path.exists(testing_path):
            os.makedirs(testing_path)
            for i in range(0, len(list_class)):
                os.mkdir(f'{testing_path}/{list_class[i]}')

    @staticmethod
    def load_image_data(image_dir):
        # Get file paths for all images in the directory
        jpeg = list(image_dir.glob(r'**/*.jpeg'))
        JPG = list(image_dir.glob(r'**/*.JPG'))
        jpg = list(image_dir.glob(r'**/*.jpg'))
        PNG = list(image_dir.glob(r'**/*.PNG'))
        png = list(image_dir.glob(r'**/*.png'))
        filepaths_ori = jpeg + JPG + jpg + PNG + png

        # Get labels for each image
        labels = list(map(lambda x: os.path.split(os.path.split(x)[0])[1], filepaths_ori))

        # Convert filepaths and labels to Pandas series
        filepaths_ori = pd.Series(filepaths_ori, name='Filepath').astype(str)
        labels = pd.Series(labels, name='Label')

        return filepaths_ori, labels

    @staticmethod
    def get_random_images(tahap):
        root_path = f'./static/dataset/{tahap}/Training/'
        num_images = 1
        random_images = []
        folder_count = 1

        # Iterasi melalui folder di dalam folder "training"
        for folder_name in os.listdir(root_path):
            folder_path = os.path.join(root_path, folder_name)

            print(folder_path)

            # Jika folder_name bukan folder, skip
            if not os.path.isdir(folder_path):
                continue

            # Mengambil daftar file di dalam folder dan mengacaknya
            file_names = os.listdir(folder_path)
            random.shuffle(file_names)

            # Memilih 1 file pertama setelah diacak
            for i in range(len(file_names)):
                if i < num_images:
                    url = f'{public_url}/static/dataset/{tahap}/Training/{folder_name}'
                    print(url)
                    random_images.append(os.path.join(url, file_names[i]))
                    print(random_images)

            # Hentikan loop setelah mengambil 5 gambar dari folder ke-5
            if folder_count == 5:
                break

            folder_count += 1

        # Mengirimkan daftar file acak sebagai respons ke Flutter
        print(random_images)
        return random_images

    @staticmethod
    def load_image_dataset(train_dataset_path, test_dataset_path):
        list_data_path = [train_dataset_path, test_dataset_path]

        # Get filepaths and labels
        image_dir_train = Path(list_data_path[0])
        filepaths_train, labels_train = GetLoadData.load_image_data(image_dir_train)

        # Concatenate filepaths and labels
        train_image_df = pd.concat([filepaths_train, labels_train], axis=1)

        # Get filepaths and labels
        image_dir_test = Path(list_data_path[1])
        filepaths_test, labels_test = GetLoadData.load_image_data(image_dir_test)

        # Concatenate filepaths and labels
        test_image_df = pd.concat([filepaths_test, labels_test], axis=1)

        # Return filepaths and labels
        return train_image_df, test_image_df
