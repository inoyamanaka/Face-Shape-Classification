// import 'dart:html';

import 'dart:io';

import 'package:face_shape/Scenes/Tampilan_ambil_gambar.dart';
import 'package:face_shape/Scenes/Tampilan_awal.dart';
import 'package:face_shape/Scenes/Tampilan_panduan.dart';
import 'package:face_shape/widgets/custom_button.dart';
import 'package:face_shape/widgets/custom_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  // late File _image;
  late File _imageFile;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width; // lebar layar
    final double height = size.height; // tinggi layar
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Column(children: [
          Container(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              "Assets/Svgs/hiasan_atas.svg",
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Pilih media",
            style: TextStyle(
                fontSize: 28,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Tentukan pilihan menggunakan gambar galeri atau foto kamera",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          CostumMedia(
            onTap: () async {
              final picker = ImagePicker();
              final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                // Lakukan sesuatu pada gambar yang dipilih
                _imageFile = File(pickedFile.path);
              }
            },
            text: "Pilih Gambar",
            imageAsset: 'Assets/Images/gallery.jpg',
          ),
          SizedBox(
            height: 15,
          ),
          CostumMedia(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    child: CameraScreen()),
                // ),
              );
            },
            text: "Pilih Gambar",
            imageAsset: 'Assets/Images/gallery.jpg',
          ),
          SizedBox(
            height: 35,
          ),
          CustomButton(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  child: PanduanScreen(),
                ),
              );
            },
            text: "Panduan",
            imageAsset: "Assets/Icons/file.png",
            width: 40,
            height: 40,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: SvgPicture.asset(
              "Assets/Svgs/hiasan_bawah.svg",
            ),
          ),
        ]),
      ),
    );
  }
}
