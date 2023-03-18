from flask import Flask, request
import os
import cv2
import mediapipe as mp
import numpy as np
from pyngrok import ngrok
from tensorflow import keras
from deepface import DeepFace
import keras.utils as image

model = keras.models.load_model('fc_model.h5')
face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_alt2.xml')

app = Flask(__name__)

from flask import Flask, request, jsonify
from werkzeug.utils import secure_filename

app = Flask(__name__, template_folder='./templates')

UPLOAD_FOLDER = './upload'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
list_class = ['Diamond','Oblong','Oval','Round','Square','Triangle']

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

        # Detect Face
        try:
            img = cv2.imread(filepath)
            DeepFace.detectFace(img)
            file.save(filepath)
            print(filepath)
            preprocessing(filepath)



            return jsonify({'message': 'File successfully uploaded'})
        except:
            path = "empty_image.png"
            return jsonify({'message': 'File failed to uploaded'})

    return jsonify({'message': 'Allowed file types are png, jpg, jpeg, gif'}), 400


@app.route('/get_images')
def get_images():
    urls = []
    for i in range(1, 5):
        filename = f'result_upload{i}.jpg'
        url = f'{public_url}/static/{filename}'
        urls.append(url)

        bentuk, persentase = prediction()
        print("apakah ini bentuk wajah : ",bentuk[0])
        print("apakah ini persentase : ", persentase)

    return jsonify({'urls': urls, 'bentuk wajah':bentuk[0], 'persen':persentase})


def preprocessing(filepath):
    face_cropping(filepath)
    detect_landmark()

def face_cropping(filepath):
    offset = 50
    img = cv2.imread(filepath)
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, 1.1, 5)

    for (x, y, w, h) in faces:
        y_offset = 20
        # faces = img[y:y + h + 30, x:x + w + 30]
        faces = img[max(0, y - offset + y_offset):min(y + h + offset + y_offset, img.shape[0]),
                max(0, x - offset):min(x + w + offset, img.shape[1])]
        # cv2.imwrite("result_image_1.jpg", faces)
        cv2.imwrite("./static/result_upload1.jpg", faces)

def detect_landmark():
    filepath = "./static/result_upload1.jpg"

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
        cv2.imwrite('./static/result_upload2.jpg', image2)


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
        cv2.imwrite('./static/result_upload3.jpg', image2)
        subtracted_img = np.zeros(image1.shape, np.uint8)

        # Lakukan perhitungan pengurangan pixel secara manual
        for i in range(image1.shape[0]):
            for j in range(image1.shape[1]):
                subtracted_img[i, j] = abs(int(image1[i, j][0]) - int(image2[i, j][0]))

        cv2.imwrite('./static/result_upload4.jpg', subtracted_img)

def prediction():
    img_width, img_height = 200, 200
    img = image.load_img("./static/result_upload4.jpg", target_size=(img_width, img_height))
    img = image.img_to_array(img)
    img = np.expand_dims(img, axis=0)
    pred = model.predict(img)

    # menghitung softmax
    softmax_pred = np.exp(pred) / np.sum(np.exp(pred), axis=1, keepdims=True)
    max_value = int(round(np.max(softmax_pred * 100)))

    pred = np.argmax(pred, axis=1)

    # Map the label
    pred = [list_class[k] for k in pred]

    return pred, max_value

if __name__ == '__main__':
    # app.run(port=8000, host='192.168.1.113')
    # ngrok.set_config(http_tunnel_port="8080")
    public_url = ngrok.connect(5000).public_url
    print(f' * Running on {public_url}')

    # Menjalankan aplikasi Flask
    app.run(port=5000)
