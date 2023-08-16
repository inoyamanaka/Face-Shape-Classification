import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class NoFaceDialog extends StatefulWidget {
  final bool isLoading;
  const NoFaceDialog({super.key, required this.isLoading});

  @override
  State<NoFaceDialog> createState() => _NoFaceDialogState();
}

AwesomeDialog NoFaceDetection(BuildContext context) {
  return AwesomeDialog(
    context: context,
    title: "Tidak terdeteksi wajah",
    body: DialogContent(),
    dialogType: DialogType.error,
    animType: AnimType.bottomSlide,
    btnOkColor: Colors.red,
    btnOkText: "Kembali",
    btnOkOnPress: () {},
  )..show();
}

Container DialogContent() {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        "Mohon maaf gambar yang anda masukan tidak terdeteksi wajah di dalamnya, mohon untuk memasukkan gambar dengan benar dan sesuai termakasih",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w500),
      ),
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
