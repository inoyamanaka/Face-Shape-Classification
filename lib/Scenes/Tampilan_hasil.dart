import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:face_shape/Datas/url_host.dart';
import 'package:face_shape/Scenes/Tampilan_menu.dart';
import 'package:face_shape/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../Datas/data_ciri_wajah.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  PageController pageController = PageController(viewportFraction: 0.7);

  double pageOffset = 0;
  double _persentase = 0;

  final List<String> imageDes = [
    "Original Image",
    "Cropping Face",
    "Facial Landmark",
    "Landmark Extraction"
  ];

  //------------------------------------------
  String _bentuk_wajah = "";
  //------------------------------------------

  List<String> _imageUrls = [];

  int _currentIndex = 0;

  Future<File> downloadFile(String url, String fileName) async {
    var response = await http.get(Uri.parse(url));
    var bytes = response.bodyBytes;
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$fileName');
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<void> fetchImages() async {
    final response = await http.get(Uri.parse('${ApiUrl.Url}/get_images'));
    if (response.statusCode == 200) {
      final List<dynamic> urls = jsonDecode(response.body)['urls'];
      _bentuk_wajah = jsonDecode(response.body)['bentuk wajah'];
      _persentase =
          double.parse(jsonDecode(response.body)['persen'].toString());
      print("ada isinya ngga sih? $_persentase");
      setState(() {
        _imageUrls = urls.cast<String>();
        _persentase = _persentase.toDouble();

        print(_bentuk_wajah.toString());

        print(_imageUrls);
      });
    } else {
      throw Exception('Failed to fetch images');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height * 0.89,
            child: SingleChildScrollView(
              child: Container(
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
                    "Hasil deteksi wajah",
                    style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    // atur lebar, tinggi, dan warna latar belakang container sesuai kebutuhan
                    width: 300,
                    height: 330,
                    child: Stack(children: [
                      Center(
                        child: SvgPicture.asset(
                          "Assets/Svgs/report_design.svg",
                        ),
                      ),
                      Positioned(
                        bottom: 70,
                        left: 12,
                        right: 12,
                        top: 55,
                        child: Container(
                          height: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CarouselSlider(
                            items: _imageUrls.map((image) {
                              return Container(
                                width: 230,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    image,
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
                                        period: Duration(milliseconds: 800),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: 230,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 12,
                        right: 12,
                        top: 0,
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 30),
                                child: Text(imageDes[_currentIndex],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w700)))),
                      )
                    ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _imageUrls.asMap().entries.map((entry) {
                      int index = entry.key;
                      // String image = entry.value;
                      return Container(
                        width: 10,
                        height: 10,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Colors.black
                              : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 210,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 217, 217, 217),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Laporan hasil deteksi",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 33),
                            child: Container(
                              width: 150,
                              child: Text(
                                "Berdasarkan hasil deteksi bentuk wajah yang anda miliki adalah bentuk wajah jenis $_bentuk_wajah",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CircularPercentIndicator(
                            radius: 50.0,
                            lineWidth: 12.0,
                            percent: (_persentase /
                                100), // nilai progress saat ini (dalam bentuk desimal)
                            center: Text("$_persentase%"), // teks persentase
                            progressColor: Color.fromARGB(255, 80, 101, 252),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 375,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 217, 217, 217),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Ciri dari wajah",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                          height: 330,
                          width: 280,
                          child: ListView.builder(
                            itemCount: Oval.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                text: Oval[index],
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
                          ))
                    ]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ]),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  child: MainMenu(),
                ),
              );
            },
            text: "main menu",
            imageAsset: "Assets/Icons/main-menu.png",
            width: 40,
            height: 40,
          ),
        ],
      ),
    );
  }
}
