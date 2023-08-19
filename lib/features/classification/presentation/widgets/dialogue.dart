import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoFaceDialog extends StatefulWidget {
  final bool isLoading;
  const NoFaceDialog({super.key, required this.isLoading});

  @override
  State<NoFaceDialog> createState() => _NoFaceDialogState();
}

AwesomeDialog noFaceDetection(BuildContext context) {
  return AwesomeDialog(
    context: context,
    title: "Tidak terdeteksi wajah",
    body: Padding(
      padding: EdgeInsets.all(10.w),
      child: Text(
        "Mohon maaf gambar yang anda masukan tidak terdeteksi wajah di dalamnya, mohon untuk memasukkan gambar dengan benar dan sesuai termakasih",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w500),
      ),
    ),
    dialogType: DialogType.error,
    animType: AnimType.bottomSlide,
    btnOkColor: Colors.red,
    btnOkText: "Kembali",
    btnOkOnPress: () {},
  )..show();
}

AwesomeDialog takePictureDialog(BuildContext context, String filePath) {
  return AwesomeDialog(
    context: context,
    title: "Gambar tersimpan",
    desc:
        "Gambar sudah tersimpan silahkan klik tombol deteksi untuk melakukan proses deteksi",
    dialogType: DialogType.success,
    animType: AnimType.bottomSlide,
    btnOkOnPress: () {},
    body: Column(
      children: [
        Image.file(
          File(filePath),
          width: 230.w,
          height: 250.h,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.all(10.w),
          child: Text(
            "Gambar sudah tersimpan silahkan klik tombol deteksi untuk melakukan proses deteksi",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

class _NoFaceDialogState extends State<NoFaceDialog> {
  @override
  Widget build(BuildContext context) {
    // return NoFaceDialog(context);
    return Container();
  }
}
