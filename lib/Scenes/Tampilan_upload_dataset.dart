import 'package:face_shape/Datas/url_host.dart';
import 'package:face_shape/Scenes/Tampilan_mode.dart';
import 'package:face_shape/Scenes/Tampilan_model_result.dart';
import 'package:face_shape/widgets/custom_media2.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class UploadDataScreen extends StatefulWidget {
  const UploadDataScreen({super.key});

  @override
  State<UploadDataScreen> createState() => _UploadDataScreenState();
}

class _UploadDataScreenState extends State<UploadDataScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> panduan = [
      "Ketentuan Dataset :",
      "Dataset harus ada dalam format zip",
      "Dataset terdiri dari 6 buah class (diamond, oblong, oval, round, triangle daan square)",
      "Dataset sudah terbagi ke dalam folder training dan testing",
      "Jumlah perbandingan data training dan testing adalah 80:20 dari total dataset yang ada"
    ];
    final Size size = MediaQuery.of(context).size;
    final double width = size.width; // lebar layar
    final double height = size.height; // tinggi layar

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    ;
    FilePickerResult? _file;

    Future<void> _uploadFile(String filename) async {
      // Mengambil path file yang dipilih
      String path = _file!.files.first.path!;

      // Membuka file sebagai byte stream
      final file = File(path);
      List<int> fileBytes = await file.readAsBytes();

      // Atau dapat menggunakan package dio
      try {
        Dio dio = new Dio();
        FormData formData = new FormData.fromMap({
          'file': await MultipartFile.fromFile(path, filename: filename),
        });
        Response response = await dio.post(ApiUrl.Url_model, data: formData);
        print("response : ${response.statusCode}");
      } catch (e) {
        print('Error uploading file: $e');
      }
    }

    Future<void> _pickFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      setState(() {
        _file = result;
        print(_file!.files.first.name);
        _uploadFile(_file!.files.first.name);
      });
    }

    return Scaffold(
      body: Container(
        // color: Color.fromRGBO(163, 45, 45, 1),
        child: Column(
          children: [
            Container(
              height: height * 0.89,
              width: width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType
                                              .rightToLeftWithFade,
                                          child: MenuMode()),
                                    );
                                  },
                                  child: Image.asset(
                                    "Assets/Icons/back.png",
                                    width: 35,
                                    height: 35,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                "Assets/Svgs/hiasan_atas.svg",
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 19, 21, 34),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Center(
                          child: Text(
                            "Upload Dataset",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 217, 217, 217),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: SizedBox(
                              height: 250,
                              width: width * 0.9,
                              child: ListView.builder(
                                itemCount: panduan.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: RichText(
                                            text: TextSpan(
                                              text: "• ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w500),
                                              children: [
                                                TextSpan(
                                                    text: panduan[index],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          width: width * 0.9,
                          height: 220,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 217, 217, 217),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "Assets/Images/folder_panduan.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                          child: InkWell(
                        onTap: () {
                          _pickFile();
                        },
                        child: Container(
                          width: width * 0.9,
                          height: 155,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "Assets/Images/data_upload.jpg",
                                  width: width * 0.9,
                                  fit: BoxFit.fill,
                                  color: Colors.black26,
                                  colorBlendMode: BlendMode.darken,
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: 150,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 19, 21, 34),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 3,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Upload Dataset",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                      SizedBox(height: 10),
                    ]),
              ),
            ),
            Spacer(),
            CustomButton2(
              isi: "Berikutnya",
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    child: ModelResultScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
