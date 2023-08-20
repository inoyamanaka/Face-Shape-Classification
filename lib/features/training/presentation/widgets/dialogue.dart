import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class UploadProgressNotifier extends ValueNotifier<double> {
  UploadProgressNotifier() : super(0.0);

  void updateProgress(double progress) {
    value = progress;
  }
}

AwesomeDialog successDialogue(BuildContext context) {
  return AwesomeDialog(
    context: context,
    title: 'Upload selesai',
    desc: 'File anda telah berhasil diunggah',
    dialogType: DialogType.success,
    btnOkOnPress: () {},
  )..show();
}
