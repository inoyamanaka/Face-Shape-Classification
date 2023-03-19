// import 'dart:html';

import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:face_shape/Datas/url_host.dart';
import 'package:face_shape/Scenes/Tampilan_ambil_gambar.dart';
import 'package:face_shape/Scenes/Tampilan_hasil.dart';
import 'package:face_shape/Scenes/Tampilan_mode.dart';
import 'package:face_shape/Scenes/Tampilan_panduan.dart';
import 'package:face_shape/widgets/custom_backbtn.dart';
import 'package:face_shape/widgets/custom_button.dart';
import 'package:face_shape/widgets/custom_media.dart';
import 'package:face_shape/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  // late File _image;
  late File _imageFile;
  bool _isLoading = false;

  //------------------------------------------
  String urlh = "http://ce71-139-0-239-34.ngrok.io";
  //------------------------------------------

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width; // lebar layar
    final double height = size.height; // tinggi layar
    return Scaffold(
      body: Stack(children: [
        Container(
          width: width,
          height: height,
          child: Column(children: [
            Container(child: CustomBackButton(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    child: MenuMode(),
                  ),
                );
              },
            )),
            SizedBox(height: 15),
            Text(
              "Pilih media",
              style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 25),
            CostumMedia(
              onTap: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  _isLoading = true;
                });
                if (pickedFile != null) {
                  final url = Uri.parse('${ApiUrl.Url}/upload');

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
                    if (jsonResponse['message'] ==
                        'File successfully uploaded') {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: ReportScreen(),
                        ),
                      );
                      // Lakukan sesuatu jika file berhasil di-upload
                    } else {
                      AwesomeDialog(
                        context: context,
                        title: "Tidak terdeteksi wajah",
                        body: Container(
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
                        ),
                        dialogType: DialogType.error,
                        animType: AnimType.bottomSlide,
                        btnOkColor: Colors.red,
                        btnOkText: "Kembali",
                        btnOkOnPress: () {
                          setState(() {
                            _isLoading = false;
                          });
                        },
                      )..show();
                      // Lakukan sesuatu jika terjadi kesalahan dalam upload file
                    }
                  } else if (response.statusCode == 307) {
                    AwesomeDialog(
                      context: context,
                      title: "Server Bermasalah",
                      body: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Mohon maaf saat ini server sedang bermasalah, mohon hubungi pemilik server untuk masalah ini",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      dialogType: DialogType.warning,
                      animType: AnimType.bottomSlide,
                      btnOkColor: Colors.red,
                      btnOkText: "Kembali",
                      btnOkOnPress: () {
                        setState(() {
                          _isLoading = false;
                        });
                      },
                    )..show();
                  } else {
                    print(
                        'Request failed with status: ${response.statusCode}.');
                  }
                }
              },
              text: "Gallery",
              imageAsset: 'Assets/Images/gallery.jpg',
            ),
            SizedBox(height: 15),
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
              text: "Camera",
              imageAsset: 'Assets/Images/camera.jpg',
            ),
            SizedBox(height: 35),
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
            Spacer(),
            Container(
              alignment: Alignment.bottomLeft,
              child: SvgPicture.asset(
                "Assets/Svgs/hiasan_bawah.svg",
              ),
            ),
          ]),
        ),
        LoadingOverlay(isLoading: _isLoading)
      ]),
    );
  }
}
