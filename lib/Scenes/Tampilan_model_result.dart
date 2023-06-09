import 'dart:convert';

import 'package:face_shape/Datas/url_host.dart';
import 'package:face_shape/Scenes/Tampilan_menu.dart';
import 'package:face_shape/Scenes/Tampilan_mode.dart';
import 'package:face_shape/Scenes/Tampilan_select_model.dart';
import 'package:face_shape/Scenes/Tampilan_verification.dart';
import 'package:face_shape/widgets/costum_hasil_deskripsi.dart';
import 'package:face_shape/widgets/costum_header.dart';
import 'package:face_shape/widgets/custom_backbtn.dart';
import 'package:face_shape/widgets/custom_button.dart';
import 'package:face_shape/widgets/custom_header_2.dart';
import 'package:face_shape/widgets/custom_image_slide.dart';
import 'package:face_shape/widgets/custom_media2.dart';
import 'package:face_shape/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';

class ModelResultScreen extends StatefulWidget {
  const ModelResultScreen({super.key});

  @override
  State<ModelResultScreen> createState() => _ModelResultScreenState();
}

Future<Map<String, dynamic>> getDataFromServer() async {
  // Lakukan request ke server
  final response = await http.get(Uri.parse(ApiUrl.Url_total_files));

  // Parse respons JSON
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    throw Exception(Text("LOOO"));
  }
}

void fetchData() async {
  var response = await http.get(Uri.parse(ApiUrl.Url_preprocessing));

  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
}

class _ModelResultScreenState extends State<ModelResultScreen> {
  List<String> _imageUrls_crop = [];
  List<String> _imageUrls_landmark = [];
  List<String> _imageUrls_extract = [];
  String _accimg = "";
  String _lossimg = "";
  String _confimg = "";
  int _persentase_train = 0;
  int _persentase_test = 0;
  bool _isLoading = true;

  Future<void> fetchImages() async {
    final response_crop = await http.get(Uri.parse(ApiUrl.Url_face_crop));
    // final response_extract = await http.get(Uri.parse(ApiUrl.Url_face_));
    if (response_crop.statusCode == 200) {
      final List<dynamic> urls_crop =
          jsonDecode(response_crop.body)['random_images'];
      // final List<dynamic> urls_extract = jsonDecode(response.body)['random_images'];
      setState(() {
        _imageUrls_crop = urls_crop.cast<String>();
        // print(_imageUrls_crop);
      });
    } else {
      throw Exception('Failed to fetch images');
    }
  }

  Future<void> fetchImages2() async {
    final response_landmark =
        await http.get(Uri.parse(ApiUrl.Url_face_landmark));
    // final response_extract = await http.get(Uri.parse(ApiUrl.Url_face_));
    if (response_landmark.statusCode == 200) {
      final List<dynamic> urls_landmark =
          jsonDecode(response_landmark.body)['random_images'];
      setState(() {
        _imageUrls_landmark = urls_landmark.cast<String>();
        // print(_imageUrls_landmark);
      });
    } else {
      throw Exception('Failed to fetch images');
    }
  }

  Future<void> fetchImages3() async {
    final response_extract = await http.get(Uri.parse(ApiUrl.Url_face_extract));
    // final response_extract = await http.get(Uri.parse(ApiUrl.Url_face_));
    if (response_extract.statusCode == 200) {
      final List<dynamic> urls_extract =
          jsonDecode(response_extract.body)['random_images'];
      setState(() {
        _imageUrls_extract = urls_extract.cast<String>();
        // print(_imageUrls_extract);
      });
    } else {
      throw Exception('Failed to fetch images');
    }
  }

  Future<void> fetchhasil() async {
    final response = await http.get(Uri.parse(ApiUrl.Url_train_model));
    // final response_extract = await http.get(Uri.parse(ApiUrl.Url_face_));
    print("response code");
    print(response.statusCode);
    print("");
    print("");
    print("");
    print("");
    print("");
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
        _persentase_train =
            (double.parse(jsonDecode(response.body)['train_acc'].toString()) *
                    100)
                .toInt();
        _persentase_test =
            (double.parse(jsonDecode(response.body)['val_acc'].toString()) *
                    100)
                .toInt();
        _accimg = jsonDecode(response.body)['plot_acc'].toString();
        _lossimg = jsonDecode(response.body)['plot_loss'].toString();
        _confimg = jsonDecode(response.body)['conf'].toString();
        print("persenstase train $_persentase_train");
        print(_accimg);
      });
    } else {
      throw Exception('Failed to fetch images');
    }
  }

  late Future<Map<String, dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = getDataFromServer();
    fetchImages2();
    fetchImages3();
    fetchhasil().then((_) {
      print("suskses");
      setState(() {
        _isLoading = false;
      });
    });
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
            MaterialPageRoute(builder: (context) => VerifScreen()),
          );
          return false;
        },
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: height,
                  child: FutureBuilder(
                      future: _futureData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var trainingValues = snapshot.data!['training'];
                          var testingValues = snapshot.data!['testing'];
                          print(trainingValues[6]);
                          return Container(
                              child: Stack(children: [
                            Column(
                              children: [
                                Container(
                                    height: height * 0.99,
                                    child: SingleChildScrollView(
                                        child: Column(children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomBackButton(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType
                                                        .rightToLeftWithFade,
                                                    child: VerifScreen()),
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          CustomHeader(isi: "Model Result"),
                                          SizedBox(height: 15),
                                          CustomHeader2(isi: "Facial Landmark"),
                                          // ignore: unnecessary_null_comparison
                                          _imageUrls_landmark != null
                                              ? ImageSlide(
                                                  imageList:
                                                      _imageUrls_landmark)
                                              : Center(
                                                  child: Container(
                                                    width: 330,
                                                    height: 300,
                                                    padding: EdgeInsets.all(10),
                                                    child: Shimmer.fromColors(
                                                        baseColor:
                                                            Colors.grey[300]!,
                                                        highlightColor:
                                                            Colors.grey[100]!,
                                                        child: Container(
                                                          color:
                                                              Colors.grey[300],
                                                        )),
                                                  ),
                                                ),
                                          SizedBox(height: 15),
                                          CustomHeader2(
                                              isi: "Landmark Extraction"),
                                          ImageSlide(
                                              imageList: _imageUrls_extract),
                                          SizedBox(height: 15),
                                          CustomHeader2(isi: "Hasil Akurasi"),
                                          SizedBox(height: 10),
                                          Center(
                                              child: HasilAkurasiCard(
                                                  "Diamong",
                                                  "Hasil Laporan Training",
                                                  "Training",
                                                  _persentase_train,
                                                  trainingValues[6])),
                                          SizedBox(height: 15),
                                          Center(
                                              child: HasilAkurasiCard(
                                                  "Oval",
                                                  "Hasil Laporan Testing",
                                                  "Testing",
                                                  _persentase_test,
                                                  testingValues[6])),
                                          SizedBox(height: 15),
                                          CustomHeader2(isi: "Plot Akurasi"),
                                          SizedBox(height: 15),
                                          Center(
                                            child: Container(
                                              height: 220,
                                              width: 280,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 217, 217, 217),
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: PhotoView(
                                                initialScale:
                                                    PhotoViewComputedScale
                                                            .contained *
                                                        1.0,
                                                backgroundDecoration:
                                                    BoxDecoration(
                                                        color: Colors.black),
                                                maxScale: PhotoViewComputedScale
                                                        .contained *
                                                    1.0,
                                                minScale: PhotoViewComputedScale
                                                        .contained *
                                                    1.0,
                                                imageProvider: NetworkImage(
                                                  _accimg,
                                                ),
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  // Jika gambar gagal dimuat karena kesalahan, tampilkan efek shimmer sebagai gantinya
                                                  return Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[100]!,
                                                    child: Container(
                                                      color: Colors.grey[300],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          Center(
                                            child: Container(
                                              height: 220,
                                              width: 280,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 217, 217, 217),
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: PhotoView(
                                                initialScale:
                                                    PhotoViewComputedScale
                                                            .contained *
                                                        0.8,
                                                backgroundDecoration:
                                                    BoxDecoration(
                                                        color: Colors.black),
                                                maxScale: PhotoViewComputedScale
                                                        .contained *
                                                    1.25,
                                                minScale: PhotoViewComputedScale
                                                    .contained,
                                                imageProvider: NetworkImage(
                                                  _lossimg,
                                                ),
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  // Jika gambar gagal dimuat karena kesalahan, tampilkan efek shimmer sebagai gantinya
                                                  return Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[100]!,
                                                    child: Container(
                                                      color: Colors.grey[300],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          Center(
                                            child: AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              height: 280,
                                              width: 280,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 217, 217, 217),
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: PhotoView(
                                                initialScale:
                                                    PhotoViewComputedScale
                                                            .contained *
                                                        0.8,
                                                backgroundDecoration:
                                                    BoxDecoration(
                                                        color: Colors.black),
                                                maxScale: PhotoViewComputedScale
                                                        .contained *
                                                    1.25,
                                                minScale: PhotoViewComputedScale
                                                    .contained,
                                                imageProvider: NetworkImage(
                                                  _confimg,
                                                ),
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  // Jika gambar gagal dimuat karena kesalahan, tampilkan efek shimmer sebagai gantinya
                                                  return Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[100]!,
                                                    child: Container(
                                                      color: Colors.grey[300],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          // CustomHeader2(isi: "Save Model "),
                                          SizedBox(height: 15),
                                          Center(
                                            child: InkWell(
                                              onTap: () {},
                                              child: AnimatedContainer(
                                                duration: Duration(seconds: 2),
                                                height: 50,
                                                width: width * 0.8,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Color.fromARGB(
                                                      255, 19, 21, 34),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 25,
                                                    ),
                                                    Image.asset(
                                                      "Assets/Icons/save.png",
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                    SizedBox(
                                                      width: 35,
                                                    ),
                                                    Text(
                                                      "Save model",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: 'Urbanist',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 100),
                                        ],
                                      ),
                                    ]))),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            LoadingOverlay(
                              text: "Mohon Tunggu Sebentar...",
                              isLoading: false,
                            )
                          ]));
                        } else if (snapshot.hasError) {
                          return Text('Terjadi kesalahan: ${snapshot.error}');
                        }
                        return Center(
                            child: LoadingOverlay(
                                text: "Proses Training model",
                                isLoading: _isLoading));
                      }),
                ),
              ],
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 10,
              child: CustomButton(
                onTap: () {
                  // deleteImgs();
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: MenuMode(),
                    ),
                  );
                },
                text: "main menu",
                imageAsset: "Assets/Icons/main-menu.png",
                width: 50,
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
