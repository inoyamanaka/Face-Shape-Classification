import 'dart:async';
import 'dart:convert';

import 'package:face_shape/Datas/color.dart';
import 'package:face_shape/Datas/url_host.dart';
import 'package:face_shape/Scenes/Tampilan_model_result.dart';
import 'package:face_shape/Scenes/Tampilan_preprocessing.dart';
import 'package:face_shape/widgets/costum_des_verif2.dart';
import 'package:face_shape/widgets/custom_backbtn.dart';
import 'package:face_shape/widgets/custom_des_verif.dart';
import 'package:face_shape/widgets/custom_media2.dart';
import 'package:face_shape/widgets/loading.dart';
import 'package:face_shape/widgets/loading2.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:http/http.dart' as http;

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class VerifScreen extends StatefulWidget {
  const VerifScreen({super.key});

  @override
  State<VerifScreen> createState() => _VerifScreenState();
}

// Fungsi untuk melakukan request ke server Flask

int _progress = 0;
int _index_pro = 0;
var total;
String _name = "name";
bool _isLoading = false;
Timer? _timer;

Future<void> doTrainModel() async {
  final response = await http.get(Uri.parse(ApiUrl.Url_train_model));
  // final response_extract = await http.get(Uri.parse(ApiUrl.Url_face_));
  // Parse respons JSON
  if (response.statusCode == 200) {
    return print(response.statusCode);
  } else {
    throw Exception('Failed to load data from server (700)');
  }
}
// ignore: unused_element

class _VerifScreenState extends State<VerifScreen> {
  bool _isLoading = false;
  String loading_text = "Mohon tunggu sebentar.....";
  String _responseText = '';

  List<String> results = [];

  Future<void> doPreprocess() async {
    // Lakukan request ke server
    _timer = Timer.periodic(Duration(seconds: 3), (_) => _fetchProgress());
    final response = await http.get(Uri.parse(ApiUrl.Url_preprocessing));
    final data = json.decode(response.body);

    print("cek");

    // Parse respons JSON
    setState(() {
      // _isLoading = true;
      _progress = data['progress'];
      _name = data['name'];
    });

    // print(response.statusCode);
    // _timer?.cancel();

    if (response.statusCode == 200) {
      // return print(response.statusCode);
      _timer?.cancel();

      print(response.statusCode);
    }
  }

  Future<void> _fetchProgress() async {
    print("cek 2");
    final response = await http.get(Uri.parse(ApiUrl.Url_fetch_progress));
    final data = json.decode(response.body);
    setState(() {
      _progress = data['progress'];
      _name = data['name'];

      print(_progress);
    });

    if (_progress == total) {
      print("progress ${_progress}");
      print(total);
      _index_pro += 1;
      if (_index_pro == 2) {
        _timer!.cancel();
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: ModelResultScreen(),
          ),
        );
      }
    }
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

  Future<void> getFain() async {
    _futureData = getDataFromServer();
  }

  Future<void> _makeRequest() async {
    final url = ApiUrl.Url_get_info; // ganti dengan endpoint Flask API Anda
    final response = await http.get(Uri.parse(url));
    final responseData = jsonDecode(response.body);
    setState(() {
      _responseText = responseData.toString();
      results = List<String>.from(responseData);
    });
  }

  late Future<Map<String, dynamic>> _futureData;
  @override
  void initState() {
    super.initState();
    _futureData = getDataFromServer();
    _makeRequest();
    // _timer = Timer.periodic(Duration(seconds: 3), (_) => _fetchProgress());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width; // lebar layar
    final double height = size.height; // tinggi l
    double progress = 0.0;

    return Scaffold(
        body: WillPopScope(
            onWillPop: () async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PreprocessingScreen()),
              );
              return false;
            },
            child: FutureBuilder<Map<String, dynamic>>(
                future: _futureData,
                builder:
                    (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingOverlay(
                      text: "Mohon Tunggu Sebentar...",
                      isLoading: true,
                    );
                  } else if (snapshot.hasError) {
                    LoadingOverlay(
                      text: "Mohon Tunggu Sebentar...",
                      isLoading: true,
                    );
                  } else if (snapshot.hasData) {
                    var trainingValues = snapshot.data!['training'];
                    var testingValues = snapshot.data!['testing'];

                    total = trainingValues[6] + testingValues[6];

                    return Container(
                      width: width,
                      height: height,
                      child: Stack(children: [
                        Column(children: [
                          Container(
                              height: height * 0.99,
                              width: width,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomBackButton(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.size,
                                                  alignment: Alignment.center,
                                                  duration:
                                                      Duration(seconds: 1),
                                                  child: PreprocessingScreen()),
                                              // ),
                                            );
                                          },
                                        ),
                                        SizedBox(height: 15),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          width: 250,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 19, 21, 34),
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20))),
                                          child: Center(
                                            child: Text(
                                              "Verification",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        width: width * 0.85,
                                                        height: 50,
                                                        color:
                                                            PrimColor.primary,
                                                        child: Center(
                                                          child: Text(
                                                              "Training",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 22,
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        width: width * 0.85,
                                                        height: height * 0.37,
                                                        decoration: BoxDecoration(
                                                            color: PrimColor
                                                                .secondary,
                                                            border: Border.all(
                                                                color: PrimColor
                                                                    .primary)),
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Data training : ${trainingValues[6]}",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              16,
                                                                          fontFamily:
                                                                              'Urbanist',
                                                                          fontWeight:
                                                                              FontWeight.w500)),
                                                                  Container(
                                                                    child: Column(
                                                                        children: [
                                                                          CustomList(
                                                                            bentuk_wajah:
                                                                                "Diamond",
                                                                            jumlah_data:
                                                                                "${trainingValues[0]}",
                                                                          ),
                                                                          CustomList(
                                                                            bentuk_wajah:
                                                                                "Oval",
                                                                            jumlah_data:
                                                                                "${trainingValues[2]}",
                                                                          ),
                                                                          CustomList(
                                                                            bentuk_wajah:
                                                                                "Round",
                                                                            jumlah_data:
                                                                                "${trainingValues[3]}",
                                                                          ),
                                                                          CustomList(
                                                                            bentuk_wajah:
                                                                                "Square",
                                                                            jumlah_data:
                                                                                "${trainingValues[4]}",
                                                                          ),
                                                                          CustomList(
                                                                            bentuk_wajah:
                                                                                "Oblong",
                                                                            jumlah_data:
                                                                                "${trainingValues[1]}",
                                                                          ),
                                                                          CustomList(
                                                                            bentuk_wajah:
                                                                                "Triangle",
                                                                            jumlah_data:
                                                                                "${trainingValues[5]}",
                                                                          ),
                                                                        ]),
                                                                  )
                                                                ])),
                                                      ),
                                                      Container(
                                                        width: width * 0.85,
                                                        height: 20,
                                                        color:
                                                            PrimColor.primary,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        width: width * 0.85,
                                                        height: 50,
                                                        color:
                                                            PrimColor.primary,
                                                        child: Center(
                                                          child: Text("Testing",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 22,
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: width * 0.85,
                                                        height: height * 0.37,
                                                        decoration: BoxDecoration(
                                                            color: PrimColor
                                                                .secondary,
                                                            border: Border.all(
                                                                color: PrimColor
                                                                    .primary)),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          width: width * 0.45,
                                                          height: height * 0.35,
                                                          color: PrimColor
                                                              .secondary,
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "Data testing : ${testingValues[6]}",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                16,
                                                                            fontFamily:
                                                                                'Urbanist',
                                                                            fontWeight:
                                                                                FontWeight.w500)),
                                                                    Container(
                                                                      child: Column(
                                                                          children: [
                                                                            CustomList(
                                                                              bentuk_wajah: "Diamond",
                                                                              jumlah_data: "${testingValues[0]}",
                                                                            ),
                                                                            CustomList(
                                                                              bentuk_wajah: "Oval",
                                                                              jumlah_data: "${testingValues[2]}",
                                                                            ),
                                                                            CustomList(
                                                                              bentuk_wajah: "Round",
                                                                              jumlah_data: "${testingValues[3]}",
                                                                            ),
                                                                            CustomList(
                                                                              bentuk_wajah: "Square",
                                                                              jumlah_data: "${testingValues[4]}",
                                                                            ),
                                                                            CustomList(
                                                                              bentuk_wajah: "Oblong",
                                                                              jumlah_data: "${testingValues[1]}",
                                                                            ),
                                                                            CustomList(
                                                                              bentuk_wajah: "Triangle",
                                                                              jumlah_data: "${testingValues[5]}",
                                                                            ),
                                                                          ]),
                                                                    )
                                                                  ])),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: width * 0.85,
                                                        height: 20,
                                                        color:
                                                            PrimColor.primary,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Center(
                                          child: Container(
                                            child: Column(children: [
                                              Container(
                                                width: width * 0.85,
                                                height: 50,
                                                color: PrimColor.primary,
                                                child: Center(
                                                  child: Text(
                                                      "Image Preprocessing",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 22,
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.85,
                                                height: height * 0.15,
                                                color: PrimColor.secondary,
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  width: width * 0.45,
                                                  height: height * 0.35,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          PrimColor.secondary,
                                                      border: Border.all(
                                                          color: PrimColor
                                                              .primary)),
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                "Daftar Image Preprocessing",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        'Urbanist',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                            Container(
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    CustomList2(
                                                                      preprocessing:
                                                                          "Facial Landmark",
                                                                    ),
                                                                    CustomList2(
                                                                      preprocessing:
                                                                          "Landmark Extraction",
                                                                    ),
                                                                  ]),
                                                            )
                                                          ])),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.85,
                                                height: 20,
                                                color: PrimColor.primary,
                                              ),
                                            ]),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Center(
                                          child: Container(
                                            child: Column(children: [
                                              Container(
                                                width: width * 0.85,
                                                height: 50,
                                                color: PrimColor.primary,
                                                child: Center(
                                                  child: Text("Model Parameter",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 22,
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.85,
                                                height: height * 0.15,
                                                decoration: BoxDecoration(
                                                    color: PrimColor.secondary,
                                                    border: Border.all(
                                                        color:
                                                            PrimColor.primary)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "Daftar parameter model",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'Urbanist',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                        Container(
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CustomList2(
                                                                  preprocessing:
                                                                      results[
                                                                          0],
                                                                ),
                                                                CustomList2(
                                                                  preprocessing:
                                                                      results[
                                                                          1],
                                                                ),
                                                                CustomList2(
                                                                  preprocessing:
                                                                      results[
                                                                          2],
                                                                ),
                                                              ]),
                                                        )
                                                      ]),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.85,
                                                height: 20,
                                                color: PrimColor.primary,
                                              ),
                                              SizedBox(
                                                height: 100,
                                              )
                                            ]),
                                          ),
                                        )
                                      ]))),
                          SizedBox(height: 5),
                        ]),
                        Positioned(
                          right: 20,
                          left: 20,
                          bottom: 10,
                          child: CustomButton2(
                            isi: "Berikutnya",
                            onTap: () {
                              setState(() {
                                _isLoading = true;
                                print(_isLoading);
                              });
                              doPreprocess().then((value) {
                                // Jika fungsi doPreprocess() berhasil dijalankan
                                // Lakukan sesuatu di sini
                              }).catchError((error) {
                                // Jika terjadi error saat menjalankan fungsi doPreprocess()
                                // Lakukan sesuatu di sini
                              });
                            },
                          ),
                        ),
                        LoadingOverlay2(
                          text: "Progress $_name ${_progress}/${total}",
                          isLoading: _isLoading,
                          name: _name,
                        ),
                      ]),
                    );
                  }
                  // Tampilkan loading spinner ketika masih loading
                  return Center(
                      child: LoadingOverlay(
                          text: "Mohon Tunggu Sebentar...", isLoading: true));
                })));
  }
}
