// ignore_for_file: unnecessary_string_interpolations

import 'package:dio/dio.dart';
import 'package:face_shape/config/config_url.dart';
import 'package:face_shape/features/training/data/models/request/param_body.dart';
import 'package:face_shape/features/training/data/models/response/param_model.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';

abstract class ParamDataSource {
  Future<ParamEntity> setParams(ParamBody body);
}

class ParamDataSourceImpl implements ParamDataSource {
  final Dio _client;

  ParamDataSourceImpl(this._client);

  @override
  Future<ParamEntity> setParams(ParamBody body) async {
    try {
      final response = await _client.post(
        '${ApiUrl.Url_params}',
        data: body.toJson(),
      );

      return ParamModel.fromJson(response.data!);
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
