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
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:http/http.dart' as http;

class VerifScreen extends StatefulWidget {
  const VerifScreen({super.key});

  @override
  State<VerifScreen> createState() => _VerifScreenState();
}

// Fungsi untuk melakukan request ke server Flask

Future<void> doPreprocess() async {
  // Lakukan request ke server
  final response = await http.get(Uri.parse(ApiUrl.Url_preprocessing));

  // Parse respons JSON
  if (response.statusCode == 200) {
    return print(response.statusCode);
  } else {
    throw Exception('Failed to load data from server (700)');
  }
}

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

  late Future<Map<String, dynamic>> _futureData;
  @override
  void initState() {
    super.initState();
    _futureData = getDataFromServer();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width; // lebar layar
    final double height = size.height; // tinggi l

    return Scaffold(
        body: WillPopScope(
            onWillPop: () async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PreprocessingScreen()),
              );
              return false;
            },
            child: FutureBuilder(
                future: _futureData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var trainingValues = snapshot.data!['training'];
                    var testingValues = snapshot.data!['testing'];

                    return Container(
                      width: width,
                      height: height,
                      child: Stack(children: [
                        Column(children: [
                          Container(
                              height: height * 0.89,
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
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: width * 0.5,
                                                      height: 50,
                                                      color: PrimColor.primary,
                                                      child: Center(
                                                        child: Text("Training",
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
                                                      width: width * 0.5,
                                                      height: height * 0.4,
                                                      color:
                                                          PrimColor.secondary,
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
                                                      width: width * 0.5,
                                                      height: 50,
                                                      color: PrimColor.primary,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: width * 0.5,
                                                      height: 50,
                                                      color: PrimColor.primary,
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
                                                      width: width * 0.5,
                                                      height: height * 0.4,
                                                      color:
                                                          PrimColor.secondary,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        width: width * 0.45,
                                                        height: height * 0.35,
                                                        color:
                                                            PrimColor.secondary,
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
                                                                            bentuk_wajah:
                                                                                "Diamond",
                                                                            jumlah_data:
                                                                                "${testingValues[0]}",
                                                                          ),
                                                                          CustomList(
                                                                            bentuk_wajah:
                                                                                "Oval",
                                                                            jumlah_data:
                                                                                "${testingValues[2]}",
                                                                          ),
                                                                          CustomList(
                                                                            bentuk_wajah:
                                                                                "Round",
                                                                            jumlah_data:
                                                                                "${testingValues[3]}",
                                                                          ),
                                                                          CustomList(
                                                                            bentuk_wajah:
                                                                                "Square",
                                                                            jumlah_data:
                                                                                "${testingValues[4]}",
                                                                          ),
                                                                          CustomList(
                                                                            bentuk_wajah:
                                                                                "Oblong",
                                                                            jumlah_data:
                                                                                "${testingValues[1]}",
                                                                          ),
                                                                          CustomList(
                                                                            bentuk_wajah:
                                                                                "Triangle",
                                                                            jumlah_data:
                                                                                "${testingValues[5]}",
                                                                          ),
                                                                        ]),
                                                                  )
                                                                ])),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width * 0.5,
                                                      height: 50,
                                                      color: PrimColor.primary,
                                                    ),
                                                  ],
                                                )
                                              ],
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
                                                  color: PrimColor.secondary,
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
                                                                          "Face Cropping",
                                                                    ),
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
                                                height: 50,
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
                                                height: height * 0.35,
                                                color: PrimColor.secondary,
                                              ),
                                              Container(
                                                width: width * 0.85,
                                                height: 50,
                                                color: PrimColor.primary,
                                              ),
                                            ]),
                                          ),
                                        )
                                      ]))),
                          Spacer(),
                          CustomButton2(
                            isi: "Berikutnya",
                            onTap: () {
                              setState(() {
                                _isLoading = true;
                                print(_isLoading);
                              });
                              doPreprocess().then((value) {
                                doTrainModel().then((value) {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType
                                          .rightToLeftWithFade,
                                      child: ModelResultScreen(),
                                    ),
                                  );
                                });
                                // Jika fungsi doPreprocess() berhasil dijalankan
                                // Lakukan sesuatu di sini
                              }).catchError((error) {
                                // Jika terjadi error saat menjalankan fungsi doPreprocess()
                                // Lakukan sesuatu di sini
                              });
                            },
                          ),
                          SizedBox(height: 5),
                        ]),
                        LoadingOverlay(isLoading: _isLoading),
                      ]),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Terjadi kesalahan: ${snapshot.error}');
                  }
                  // Tampilkan loading spinner ketika masih loading
                  return Center(child: LoadingOverlay(isLoading: true));
                })));
  }
}
