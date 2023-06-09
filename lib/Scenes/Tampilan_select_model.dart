// ignore_for_file: dead_code

import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:face_shape/Datas/color.dart';
import 'package:face_shape/Datas/url_host.dart';
import 'package:face_shape/Scenes/Tampilan_mode.dart';
import 'package:face_shape/widgets/costum_header.dart';
import 'package:face_shape/widgets/custom_backbtn.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;

class SelectModelScreen extends StatefulWidget {
  const SelectModelScreen({super.key});

  @override
  State<SelectModelScreen> createState() => _SelectModelScreenState();
}

class _SelectModelScreenState extends State<SelectModelScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  int total_models = 0;
  final allowedExtensions = ['.h5'];

  FilePickerResult? _file;
  PlatformFile? _platformFile;
  late AnimationController loadingController;

  void _sendSelectedIndexToBackend(String index) async {
    final url = '${ApiUrl.Url_selected_models}';
    final response = await http.post(Uri.parse(url), body: {'index': index});
    if (response.statusCode == 200) {
      // do something on success
      print("sukses");
    } else {
      // do something on failure
    }
  }

  Future<void> countFiles() async {
    final response = await http.get(Uri.parse('${ApiUrl.Url_total_models}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      total_models = data['count'];
      print(total_models);
      setState(() {});
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _uploadFile(String filename, int index) async {
    // Mengambil path file yang dipilih
    String path = _file!.files.first.path!;
    try {
      Dio dio = new Dio();
      FormData formData = new FormData.fromMap({
        'file': await MultipartFile.fromFile(path, filename: filename),
      });

      setState(() {
        loadingController.value = 0.0;
      });

      Response response = await dio.post(ApiUrl.Url_import_model,
          data: formData, onSendProgress: (int sentBytes, int totalBytes) {
        double progressPercent = (sentBytes / totalBytes) * 100 / 100;
        setState(() {
          loadingController.value = progressPercent;
          print(progressPercent);
          if (loadingController.value == 1.0) {}
        });
      });

      if (response.statusCode == 200) {
        AwesomeDialog(
          context: context,
          title: 'Upload selesai',
          desc: 'File anda telah berhasil diunggah',
          dialogType: DialogType.success,
          btnOkOnPress: () {},
        )..show();
      }

      setState(() {
        loadingController.value = 1.0;
      });

      print("response : ${response.statusCode}");
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _file = result;
        // _file2 = File(result.files.single.path!);
        _platformFile = result.files.first;
        _uploadFile(_file!.files.first.name, 0);
      });
    }
  }

  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
    countFiles();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width; // lebar layar
    final double height = size.height; // tinggi layar

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MenuMode()),
          );
          return false;
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: 730,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomBackButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: MenuMode()),
                      // ),
                    );
                  },
                ),
                SizedBox(height: 15),
                CustomHeader(isi: "Pilih model AI"),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    width: width * 0.89,
                    height: 100,
                    color: Colors.amber,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Berikut merupakan daftar model yang tersedia dan dapat digunakan untuk melakukan proses klasifikasi bentuk wajah",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w300,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _platformFile != null
                    ? Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selected File',
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade200,
                                        offset: Offset(0, 1),
                                        blurRadius: 3,
                                        spreadRadius: 2,
                                      )
                                    ]),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          "Assets/Images/zip-file.png",
                                          width: 35,
                                          height: 35,
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _platformFile!.name,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${(_platformFile!.size / 1024).ceil()} KB',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey.shade500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                              height: 5,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.blue.shade50,
                                              ),
                                              child: LinearProgressIndicator(
                                                value: loadingController.value,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ))
                    : Container(),
                Container(
                  height: total_models * 50 + 300,
                  child: Expanded(
                      flex: 1,
                      child: Container(
                          // height: 300,
                          child: ListView.builder(
                        itemCount: total_models,
                        itemBuilder: (BuildContext context, int index) {
                          List<String> imagebg = [
                            "Assets/Images/model (1).jpg",
                            "Assets/Images/model (2).jpg",
                            "Assets/Images/model (3).jpg",
                            "Assets/Images/model (4).jpg",
                            "Assets/Images/model (5).jpg"
                          ];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.question,
                                  animType: AnimType.scale,
                                  title: 'Confirmation',
                                  desc:
                                      'Are you sure you want to select Model ${index + 1}?',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    _sendSelectedIndexToBackend(
                                        (index + 1).toString());
                                  },
                                )..show();
                              });
                            },
                            child: Column(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  width: 300,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 3,
                                    ),
                                  ),
                                  child: ClipPath(
                                    child: Stack(children: [
                                      Image.asset(
                                        width: 300,
                                        height: 120,
                                        imagebg[index],
                                        fit: BoxFit.cover,
                                      ),
                                      Center(
                                          child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          "Model ${index + 1}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )),
                                    ]),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          );
                        },
                      ))),
                ),
                // Spacer(),
                // SizedBox(height: 10),
                Center(
                  child: InkWell(
                    onTap: () {
                      _pickFile();
                      setState(() {});
                    },
                    child: AnimatedContainer(
                      duration: Duration(seconds: 2),
                      height: 50,
                      width: width * 0.9,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 19, 21, 34),
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          Image.asset(
                            "Assets/Icons/import.png",
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            "Import model",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Urbanist',
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FileData {
  late PlatformFile platformFile;
  late double progressPercent;
  late ValueNotifier<double> loadingController;

  _FileData({
    required this.platformFile,
    required this.progressPercent,
  }) {
    loadingController = ValueNotifier(progressPercent);
  }
}
