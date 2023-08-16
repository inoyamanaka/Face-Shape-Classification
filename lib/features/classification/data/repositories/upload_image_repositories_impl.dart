import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:face_shape/config/config_url.dart';
import 'package:face_shape/core/models/error/failures.dart';
import 'package:face_shape/features/classification/domain/entities/user_image.dart';
import 'package:face_shape/features/classification/domain/repositories/upload_image_repositories.dart';
import 'package:http/http.dart' as http;


class UploadImageRepositoryImpl implements UploadImageRepository {
  @override
  Future<Either<Failure, ImageEntitiy>> uploadImage(String filePath) async {

try{

}except(e){}



    // print("ini terpanggil ?");
    final url = Uri.parse('${ApiUrl.Url_pred}');

    final request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('file', filePath));
    final client = http.Client();
    final response = await client
        .send(request)
        .then((response) => http.Response.fromStream(response));

    // print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print("response: " + jsonResponse.toString());
      if (jsonResponse['message'] == 'File successfully uploaded') {
        return true;
      }
    }

    return false;
  }
}
