// ignore_for_file: unnecessary_string_interpolations

import 'package:dio/dio.dart';
import 'package:face_shape/config/config_url.dart';
import 'package:face_shape/features/training/data/models/response/data_info_model.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';

abstract class DataInfoDataSource {
  Future<DataInfoEntity> getInfoData();
}

class DataInfoDataSourceImpl implements DataInfoDataSource {
  final Dio _client;

  DataInfoDataSourceImpl(this._client);
  @override
  Future<DataInfoEntity> getInfoData() async {
    try {
      final result = await _client.get(
        '${ApiUrl.Url_get_info}',
        options: Options(headers: {}),
      );
      return DataInfoModel.fromJson(result.data!);
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        error: e.error,
        response: e.response,
      );
    } catch (e) {
      rethrow;
    }
  }
}
