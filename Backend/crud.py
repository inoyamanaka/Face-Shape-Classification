import os
import cv2
from flask import Flask, request, jsonify
from werkzeug.utils import secure_filename

#-----------------------------------------------------
# Tempat setting server
UPLOAD_FOLDER = './upload'
UPLOAD_MODEL = './models'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg','zip','h5'}
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['UPLOAD_MODEL'] = UPLOAD_MODEL
app.config['MAX_CONTENT_LENGTH'] = 500 * 1024 * 1024  # 500 MB
#-----------------------------------------------------


class FaceDetectionApp:
    def __init__(self, upload_folder="./static", public_url="/"):
        self.app = Flask(__name__)
        self.app.config['UPLOAD_FOLDER'] = upload_folder
        self.app.config['UPLOAD_MODEL'] = os.path.join(upload_folder, "model")
        self.public_url = public_url

        def delete_img():
            for i in range (0,4):
                if os.path.exists(f"./static/result_upload{i}.jpg"):
                    os.remove(f"./static/result_upload{i}.jpg")
                    print("File terhapus")
                    return jsonify({'message': 'Berhasil di hapus'}), 400
                else:
                    print("File tidak ditemukan.")
                    return jsonify({'message': 'No file selected for uploading'}), 400

        def upload_file():
            if 'file' not in request.files:
                return jsonify({'message': 'No file part in the request'}), 400

            file = request.files['file']

            if file.filename == '':
                return jsonify({'message': 'No file selected for uploading'}), 400

            filename = secure_filename(file.filename)
            filepath = os.path.join(self.app.config['UPLOAD_FOLDER'], filename)
            file.save(filepath)
            img = cv2.imread(filepath)
            # Detect Face
            try:
                self.preprocessing(img)
                return jsonify({'message': 'File successfully uploaded'})
            except:
                path = "empty_image.png"
                return jsonify({'message': 'File failed to uploaded'})

        def upload_data():
            if 'file' not in request.files:
                return jsonify({'message': 'No file part in the request'}), 400

            file = request.files['file']

            if file.filename == '':
                return jsonify({'message': 'No file selected for uploading'}), 400

            if file and self.allowed_file(file.filename):
                filename = secure_filename(file.filename)
                filepath = os.path.join(self.app.config['UPLOAD_FOLDER'], filename)
                file.save(filepath)

                self.extract_zip(filepath)
                return jsonify({'message': 'File successfully uploaded'})

            return jsonify({'message': 'File failed to uploaded'})


        def upload_model():
            if 'file' not in request.files:
                return jsonify({'message': 'No file part in the request'}), 400

            file = request.files['file']

            if file.filename == '':
                return jsonify({'message': 'No file selected for uploading'}), 400

            if file and self.allowed_file(file.filename):
                filename = secure_filename(file.filename)
                filepath = os.path.join(self.app.config['UPLOAD_MODEL'], filename)
                file.save(filepath)

                return jsonify({'message': 'File successfully uploaded'})

            return jsonify({'message': 'File failed to uploaded'})

        def get_total_files():
            training_counts = self.get_training_file_counts()
            testing_counts = self.get_testing_file_counts()
            result = {}
            result['training'] = training_counts.json
            result['testing'] = testing_counts.json
            return jsonify(result)