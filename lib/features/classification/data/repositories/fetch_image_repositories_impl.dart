import 'dart:convert';

import 'package:face_shape/config/config_url.dart';
import 'package:face_shape/features/classification/domain/entities/user_image.dart';
import 'package:face_shape/features/classification/domain/repositories/fetch_image_repositories.dart';
import 'package:http/http.dart' as http;

class FetchImageRepositoryImpl implements FetchImageRepository {
  @override
  Future<UserImage> fetchUserImageAtt() async {
    final response = await http.get(Uri.parse('${ApiUrl.Url}/get_images'));
    if (response.statusCode == 200) {
      final List<String> url = jsonDecode(response.body)['urls'];
      final String bentukWajah = jsonDecode(response.body)['bentuk wajah'];
      final double persentase =
          double.parse(jsonDecode(response.body)['persen'].toString());

      return UserImage(url, bentukWajah, persentase);
    } else {
      throw Exception('Failed to fetch images');
    }
  }
}
