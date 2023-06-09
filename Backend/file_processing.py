import zipfile

class FileProcess:
    ALLOWED_EXTENSIONS = {'zip'}

    @staticmethod
    def allowed_file(filename):
        return '.' in filename and \
               filename.rsplit('.', 1)[1].lower() in FileProcess.ALLOWED_EXTENSIONS

    @staticmethod
    def extract_zip(filepath):
        path_ke_folder = './static/dataset/'
        with zipfile.ZipFile(filepath, 'r') as zip_ref:
            zip_ref.extractall(path_ke_folder)
