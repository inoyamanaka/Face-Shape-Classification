from flask import Flask, request
import os
import cv2
import mediapipe as mp
import numpy as np
from pyngrok import ngrok

app = Flask(__name__)

from flask import Flask, request, jsonify
from werkzeug.utils import secure_filename

app = Flask(__name__, template_folder='./templates')

UPLOAD_FOLDER = './upload'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

# INITIALIZING OBJECTS
mp_drawing = mp.solutions.drawing_utils
mp_face_mesh = mp.solutions.face_mesh
drawing_spec = mp_drawing.DrawingSpec(thickness=1, circle_radius=1)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({'message': 'No file part in the request'}), 400

    file = request.files['file']

    if file.filename == '':
        return jsonify({'message': 'No file selected for uploading'}), 400

    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(filepath)
        detect_landmark(filepath)
        return jsonify({'message': 'File successfully uploaded'})

    return jsonify({'message': 'Allowed file types are png, jpg, jpeg, gif'}), 400


@app.route('/get_images')
def get_images():
    urls = []
    for i in range(1, 4):
        filename = f'result_upload{i}.jpg'
        url = f'{public_url}/static/{filename}'
        urls.append(url)
    return jsonify({'urls': urls})

def detect_landmark(filepath):
    print("jalan : ", filepath)
    # READ IMAGE FILE
    image1 = cv2.imread(filepath)
    image1 = cv2.resize(image1, (220, 280), interpolation=cv2.INTER_AREA)

    image2 = cv2.imread(filepath)
    image2 = cv2.resize(image2, (220, 280), interpolation=cv2.INTER_AREA)

    # DETECT THE FACE LANDMARKS
    with mp_face_mesh.FaceMesh(min_detection_confidence=0.1, min_tracking_confidence=0.6) as face_mesh:

        # Flip the image horizontally and convert the color space from BGR to RGB
        image2 = cv2.cvtColor(image2, cv2.COLOR_BGR2RGB)

        # To improve performance
        image2.flags.writeable = False

        # Detect the face landmarks
        results = face_mesh.process(image2)

        # To improve performance
        image2.flags.writeable = True

        # Convert back to the BGR color space
        image2 = cv2.cvtColor(image2, cv2.COLOR_RGB2BGR)
        cv2.imwrite('./static/result_upload1.jpg', image2)


        # Draw the face mesh annotations on the image.
        if results.multi_face_landmarks:
            for face_landmarks in results.multi_face_landmarks:
                mp_drawing.draw_landmarks(
                    image=image2,
                    landmark_list=face_landmarks,
                    connections=mp_face_mesh.FACEMESH_TESSELATION,
                    landmark_drawing_spec=mp_drawing.DrawingSpec(color=(0, 0, 0), thickness=0, circle_radius=0),
                    connection_drawing_spec=mp_drawing.DrawingSpec(color=(0, 0, 255), thickness=1, circle_radius=0))

        # imagen = imageb - image
        # imagen = cv2.subtract(image, imageb)
        cv2.imwrite('./static/result_upload2.jpg', image2)
        subtracted_img = np.zeros(image1.shape, np.uint8)

        # Lakukan perhitungan pengurangan pixel secara manual
        for i in range(image1.shape[0]):
            for j in range(image1.shape[1]):
                subtracted_img[i, j] = abs(int(image1[i, j][0]) - int(image2[i, j][0]))

        cv2.imwrite('./static/result_upload3.jpg', subtracted_img)

if __name__ == '__main__':
    # app.run(port=8000, host='192.168.1.113')
    public_url = ngrok.connect(5000).public_url
    print(f' * Running on {public_url}')

    # Menjalankan aplikasi Flask
    app.run(port=5000)
