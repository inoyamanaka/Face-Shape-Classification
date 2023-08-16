import 'package:face_shape/config/config_url.dart';
import 'package:face_shape/features/classification/domain/repositories/set_parameters.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SetparamsImpl implements SetParams {
  Future<void> sendDropdownValue(String dropdownValue) async {
    final url = ApiUrl.Url_optimizer;
    final response = await http.post(Uri.parse(url), body: {
      'value': dropdownValue,
    });
  }

  Future<void> sendTextFieldEpoch(String textFieldValue) async {
    final url = ApiUrl.Url_epoch;
    final response =
        await http.post(Uri.parse(url), body: {'value': textFieldValue});
    if (response.statusCode == 200) {
      print('Textfield value sent successfully');
    } else {
      print('Failed to send textfield value');
    }
  }

  Future<int> sendTextFieldBatch(String textFieldValue) async {
    final url = ApiUrl.Url_batch_size;
    final response =
        await http.post(Uri.parse(url), body: {'value': textFieldValue});

    return response.statusCode;
  }
}
