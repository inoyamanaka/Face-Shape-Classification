import os
import cv2
import numpy as np
import mediapipe as mp
from deepface import DeepFace

class DataProcessing:
    def __init__(self):
        self.face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
        self.mp_face_mesh = mp.solutions.face_mesh
        self.mp_drawing = mp.solutions.drawing_utils

    def enhance_contrast_histeq(self, image):
        # Konversi gambar menjadi mode Grayscale
        img = image.copy()
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

        # Terapkan histogram equalization
        enhanced_image = cv2.equalizeHist(gray)
        cv2.imwrite("./static/result_upload2.jpg", enhanced_image)

        return enhanced_image

    def face_cropping_pred(self, img):
        print("test2")
        for i in range(0, 4):
            if os.path.exists(f"./static/result_upload{i}.jpg"):
                os.remove(f"./static/result_upload{i}.jpg")
                print("File terhapus")
            else:
                print("File tidak ditemukan.")

        # img = cv2.imread(filepath)
        cv2.imwrite("./static/result_upload0.jpg", img)
        cv2.imwrite('./static/temporary/result_upload0.jpg', img)
        try:
            DeepFace.extract_faces("./static/result_upload0.jpg")
            offset = 40
            # img = cv2.imread(filepath)
            gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
            faces = self.face_cascade.detectMultiScale(gray, 1.1, 5)

            for (x, y, w, h) in faces:
                y_offset = -20
                # faces = img[y:y + h + 30, x:x + w + 30]
                faces = img[max(0, y - offset + y_offset):min(y + h + offset + y_offset, img.shape[0]),
                        max(0, x - offset):min(x + w + offset, img.shape[1])]
                cv2.imwrite("./static/result_upload1.jpg", faces)
                cv2.imwrite('./static/temporary/result_upload1.jpg', faces)

                return faces
        except:
            print("error")

    def detect_landmark(self, img):

        print("test")
        image1 = img.copy()
        image2 = img.copy()

        with self.mp_face_mesh.FaceMesh(min_detection_confidence=0.1, min_tracking_confidence=0.6) as face_mesh:
            image2 = cv2.cvtColor(image2, cv2.COLOR_BGR2RGB)
            image2.flags.writeable = False
            results = face_mesh.process(image2)
            image2.flags.writeable = True
            image2 = cv2.cvtColor(image2, cv2.COLOR_RGB2BGR)

            if results.multi_face_landmarks:
                for face_landmarks in results.multi_face_landmarks:
                    self.mp_drawing.draw_landmarks(
                        image=image2,
                        landmark_list=face_landmarks,
                        connections=self.mp_face_mesh.FACEMESH_TESSELATION,
                        landmark_drawing_spec=self.mp_drawing.DrawingSpec(color=(0, 0, 0), thickness=0, circle_radius=0),
                        connection_drawing_spec=self.mp_drawing.DrawingSpec(color=(0, 0, 255), thickness=1, circle_radius=0))

            cv2.imwrite('./static/result_upload2.jpg', image2)
            cv2.imwrite('./static/temporary/result_upload2.jpg', image2)

            subtracted_img = np.zeros(image1.shape, np.uint8)

            for i in range(image1.shape[0]):
                for j in range(image1.shape[1]):
                    subtracted_img[i, j] = abs(int(image1[i, j][0]) - int(image2[i, j][0]))

            cv2.imwrite('./static/result_upload3.jpg', subtracted_img)
            cv2.imwrite('./static/temporary/result_upload3.jpg', subtracted_img)

    def annotate_face_mesh(self, image):
        with self.mp_face_mesh.FaceMesh(min_detection_confidence=0.1, min_tracking_confidence=0.6) as face_mesh:
            image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
            image.flags.writeable = False
            results = face_mesh.process(image)
            image.flags.writeable = True
            image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)

            if results.multi_face_landmarks:
                for face_landmarks in results.multi_face_landmarks:
                    self.mp_drawing.draw_landmarks(
                        image=image,
                        landmark_list=face_landmarks,
                        connections=self.mp_face_mesh.FACEMESH_TESSELATION,
                        landmark_drawing_spec=self.mp_drawing.DrawingSpec(color=(0, 0, 0), thickness=0, circle_radius=0),
                        connection_drawing_spec=self.mp_drawing.DrawingSpec(color=(0, 0, 255), thickness=1, circle_radius=0))
            return image


