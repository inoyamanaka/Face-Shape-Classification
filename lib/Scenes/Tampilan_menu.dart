// import 'dart:html';

import 'dart:io';

import 'package:face_shape/Scenes/Tampilan_ambil_gambar.dart';
import 'package:face_shape/Scenes/Tampilan_hasil.dart';
import 'package:face_shape/Scenes/Tampilan_panduan.dart';
import 'package:face_shape/widgets/custom_button.dart';
import 'package:face_shape/widgets/custom_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart'
    show rootBundle, ByteData, PlatformException;

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  // late File _image;
  late File _imageFile;

  Future<void> copyImageToAssets(String imagePath, String assetPath) async {
    try {
      // Buka file gambar dari path yang diberikan
      final File imageFile = File(imagePath);
      print("cell");

      // Baca file gambar sebagai byte data
      final ByteData imageData = await imageFile
          .readAsBytes()
          .then((data) => ByteData.view(data.buffer));

      print("cell2");

      // Salin file gambar ke dalam folder aset
      await writeToFile(imageData, assetPath);

      //   print("File berhasil disalin ke folder aset");
    } on PlatformException catch (e) {
      print("Gagal menyalin file ke folder aset: $e");
    }
  }

  Future<void> writeToFile(ByteData data, String path) {
    return new File(path).writeAsBytes(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

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
                final url = Uri.parse('http://192.168.1.113:8000/upload');

                final request = http.MultipartRequest('POST', url)
                  ..files.add(await http.MultipartFile.fromPath(
                      'file', pickedFile.path));
                final client = http.Client();
                final response = await client
                    .send(request)
                    .then((response) => http.Response.fromStream(response));

                if (response.statusCode == 200) {
                  final jsonResponse = json.decode(response.body);
                  print("response: " + jsonResponse.toString());
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: ReportScreen(),
                    ),
                  );
                } else {
                  print('Request failed with status: ${response.statusCode}.');
                }
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
                    type: PageTransitionType.size,
                    alignment: Alignment.center,
                    duration: Duration(seconds: 1),
                    child: CameraScreen()),
                // ),
              );
            },
            text: "Ambil Gambar",
            imageAsset: 'Assets/Images/camera.jpg',
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
