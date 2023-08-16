import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:face_shape/features/classification/presentation/pages/main_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class UploadProgressNotifier extends ValueNotifier<double> {
  UploadProgressNotifier() : super(0.0);

  void updateProgress(double progress) {
    value = progress;
  }
}

class SuccesDialog extends StatelessWidget {
  const SuccesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

AwesomeDialog SuccesUpload(BuildContext context) {
  return AwesomeDialog(
    context: context,
    title: 'Upload selesai',
    desc: 'File anda telah berhasil diunggah',
    dialogType: DialogType.success,
    btnOkOnPress: () {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          child: MenuMode(),
        ),
      );
    },
  )..show();
  ;
}

AwesomeDialog uploadSuccessImage(BuildContext context, String? filePath) {
  return AwesomeDialog(
    context: context,
    title: "Gambar tersimpan",
    dialogType: DialogType.success,
    animType: AnimType.bottomSlide,
    btnOkOnPress: () {},
    body: Container(
      child: Column(
        children: [
          Image.file(
            File(filePath!),
            width: 230,
            height: 250,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Gambar sudah tersimpan silahkan klik tombol deteksi untuk melakukan proses deteksi",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    ),
  )..show();
}
