import 'dart:convert';

import 'package:face_shape/Datas/url_host.dart';
import 'package:face_shape/Scenes/Tampilan_select_model.dart';
import 'package:face_shape/Scenes/Tampilan_verification.dart';
import 'package:face_shape/widgets/costum_hasil_deskripsi.dart';
import 'package:face_shape/widgets/costum_header.dart';
import 'package:face_shape/widgets/custom_backbtn.dart';
import 'package:face_shape/widgets/custom_header_2.dart';
import 'package:face_shape/widgets/custom_image_slide.dart';
import 'package:face_shape/widgets/custom_media2.dart';
import 'package:face_shape/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

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
    var testingValues = jsonResponse['testing'];
    var valueAtIndex6 = testingValues[1];
    print(valueAtIndex6);
    return jsonResponse;
  } else {
    throw Exception(Text("LOOO"));
  }
}

void fetchData() async {
  var response = await http.get(Uri.parse(ApiUrl.Url_preprocessing));

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}

class _ModelResultScreenState extends State<ModelResultScreen> {
  List<String> _imageUrls_crop = [];
  List<String> _imageUrls_landmark = [];
  List<String> _imageUrls_extract = [];
  int _persentase_train = 0;
  int _persentase_test = 0;

  Future<void> fetchImages() async {
    final response_crop = await http.get(Uri.parse(ApiUrl.Url_face_crop));
    // final response_extract = await http.get(Uri.parse(ApiUrl.Url_face_));
    if (response_crop.statusCode == 200) {
      final List<dynamic> urls_crop =
          jsonDecode(response_crop.body)['random_images'];
      // final List<dynamic> urls_extract = jsonDecode(response.body)['random_images'];
      setState(() {
        _imageUrls_crop = urls_crop.cast<String>();
        print(_imageUrls_crop);
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
        print(_imageUrls_landmark);
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
        print(_imageUrls_extract);
      });
    } else {
      throw Exception('Failed to fetch images');
    }
  }

  Future<void> fetchhasil() async {
    final response_extract = await http.get(Uri.parse(ApiUrl.Url_train_model));
    // final response_extract = await http.get(Uri.parse(ApiUrl.Url_face_));
    if (response_extract.statusCode == 200) {
      setState(() {
        _persentase_train = (double.parse(
                    jsonDecode(response_extract.body)['train_acc'].toString()) *
                100)
            .toInt();
        _persentase_test = (double.parse(
                    jsonDecode(response_extract.body)['val_acc'].toString()) *
                100)
            .toInt();
        print("persenstase train $_persentase_train");
        print(_persentase_test);
      });
    } else {
      throw Exception('Failed to fetch images');
    }
  }

  late Future<Map<String, dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    // fetchData();
    // fetchImages();
    // fetchImages2();
    // fetchImages3();
    fetchhasil();
    _futureData = getDataFromServer();
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
        child: FutureBuilder(
            future: _futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var trainingValues = snapshot.data!['training'];
                var testingValues = snapshot.data!['testing'];
                print(trainingValues[6]);
                return Container(
                    child: Column(
                  children: [
                    Container(
                        height: height * 0.89,
                        child: SingleChildScrollView(
                            child: Column(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              ImageSlide(imageList: _imageUrls_landmark),
                              SizedBox(height: 15),
                              CustomHeader2(isi: "Landmark Extraction"),
                              ImageSlide(imageList: _imageUrls_extract),
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
                              CustomHeader2(isi: "Hasil Tambahan"),
                              SizedBox(height: 15),
                              Center(
                                child: Container(
                                  height: 200,
                                  width: 280,
                                  color: Color.fromARGB(255, 217, 217, 217),
                                  child: Image.network(
                                    "nanti_diisi_url",
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      // Jika gambar gagal dimuat karena kesalahan, tampilkan efek shimmer sebagai gantinya
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
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
                                  duration: Duration(milliseconds: 500),
                                  height: 200,
                                  width: 280,
                                  color: Color.fromARGB(255, 217, 217, 217),
                                  child: Image.network(
                                    "nanti_diisi_url",
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      // Jika gambar gagal dimuat karena kesalahan, tampilkan efek shimmer sebagai gantinya
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          color: Colors.grey[300],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]))),
                    Spacer(),
                    CustomButton2(
                      isi: "Berikutnya",
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: SelectModelScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ));
              } else if (snapshot.hasError) {
                return Text('Terjadi kesalahan: ${snapshot.error}');
              }
              return Center(child: LoadingOverlay(isLoading: true));
            }),
      ),
    );
  }
}
