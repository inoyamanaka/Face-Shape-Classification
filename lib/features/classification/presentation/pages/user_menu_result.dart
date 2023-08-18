import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:face_shape/Datas/url_host.dart';
import 'package:face_shape/core/models/ciri_wajah.dart';
import 'package:face_shape/core/router/routes.dart';
import 'package:face_shape/features/classification/presentation/widgets/custom_button.dart';
import 'package:face_shape/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  void deleteImgs() async {
    await http.get(Uri.parse(ApiUrl.Url_delete_img));
  }

  PageController pageController = PageController(viewportFraction: 0.7);

  double pageOffset = 0;
  double _persentase = 0;
  bool _isLoading = false;

  final List<String> imageDes = [
    "Original Image",
    "Face Cropping",
    "Facial Landmark",
    "Landmark Extraction"
  ];

  //------------------------------------------
  String _bentuk_wajah = "";
  //------------------------------------------

  List<String> _imageUrls = [];

  int _currentIndex = 0;

  Future<void> fetchImages() async {
    final response = await http.get(Uri.parse('${ApiUrl.Url}/get_images'));
    if (response.statusCode == 200) {
      final List<dynamic> urls = jsonDecode(response.body)['urls'];
      _bentuk_wajah = jsonDecode(response.body)['bentuk wajah'];
      _persentase =
          double.parse(jsonDecode(response.body)['persen'].toString());
      print("ada isinya ngga sih? $_persentase");
      setState(() {
        _isLoading = false;
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

    final ciriWajah = CiriWajah();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Get.toNamed(Routes.userCamera);
          return false;
        },
        child: Stack(children: [
          Column(
            children: [
              SizedBox(
                height: height,
                child: SingleChildScrollView(
                  child: Column(children: [
                    TopDecoration(),
                    const SizedBox(height: 15),
                    TitlePage(),
                    const SizedBox(height: 5),
                    imageResult(),
                    sliderIndicator(),
                    const SizedBox(height: 15),
                    imageResult2(height),
                    const SizedBox(height: 15),
                    imageResult3(ciriWajah),
                    const SizedBox(height: 90)
                  ]),
                ),
              ),
            ],
          ),
          backButtonUser(context),
          LoadingOverlay(
              text: "Mohon Tunggu Sebentar...", isLoading: _isLoading)
        ]),
      ),
    );
  }

  Positioned backButtonUser(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 10,
      child: CustomButton(
        onTap: () {
          deleteImgs();
          Get.toNamed(Routes.menu);
        },
        text: "main menu",
        imageAsset: "Assets/Icons/main-menu.png",
        width: 50,
        height: 40,
      ),
    );
  }

  Container imageResult3(CiriWajah ciriWajah) {
    return Container(
      height: 355,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 217, 217, 217),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Column(children: [
        const SizedBox(height: 15),
        const Text(
          "Ciri dari wajah",
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 250,
          width: 280,
          child: ciriWajah.faceShapes.containsKey(_bentuk_wajah)
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    // final bentukWajah =
                    //     ciriWajah.faceShapes.keys.elementAt(index);
                    // print(bentukWajah);
                    final deskripsiWajah = ciriWajah.faceShapes[_bentuk_wajah]!;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: RichText(
                              text: TextSpan(
                                text: "• ",
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                      text: deskripsiWajah[index],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              : Container(),
        )
      ]),
    );
  }

  Container imageResult2(double height) {
    return Container(
      height: height * 0.3,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 217, 217, 217),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Column(children: [
        const SizedBox(height: 15),
        subTitleLaporan(),
        Row(
          children: [
            faceShapeResult(),
            const SizedBox(width: 5),
            faceShapePercent(),
          ],
        ),
      ]),
    );
  }

  CircularPercentIndicator faceShapePercent() {
    return CircularPercentIndicator(
      radius: 50.0,
      lineWidth: 12.0,

      percent:
          (_persentase / 100), // nilai progress saat ini (dalam bentuk desimal)
      center: Text("$_persentase%"), // teks persentase
      progressColor: const Color.fromARGB(255, 80, 101, 252),
    );
  }

  Padding faceShapeResult() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 33),
      child: SizedBox(
        width: 150,
        child: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16.0, color: Colors.black),
            children: [
              const TextSpan(
                  text:
                      'Berdasarkan hasil deteksi bentuk wajah yang anda miliki adalah bentuk wajah jenis ',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w300)),
              TextSpan(
                  text: '$_bentuk_wajah',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Text subTitleLaporan() {
    return const Text(
      "Laporan hasil deteksi",
      style: TextStyle(
          fontSize: 18, fontFamily: 'Urbanist', fontWeight: FontWeight.w700),
    );
  }

  SizedBox imageResult() {
    return SizedBox(
      // atur lebar, tinggi, dan warna latar belakang container sesuai kebutuhan
      width: 300,
      height: 330,
      child: Stack(children: [
        Center(
          child: SvgPicture.asset(
            "Assets/Svgs/report_design.svg",
          ),
        ),
        imagePreprocessBox(),
        imagePreprocessDetail()
      ]),
    );
  }

  Row sliderIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _imageUrls.asMap().entries.map((entry) {
        int index = entry.key;
        // String image = entry.value;
        return AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: _currentIndex == index ? 25 : 10,
          height: 10,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: _currentIndex == index ? Colors.black : Colors.grey,
          ),
        );
      }).toList(),
    );
  }

  Positioned imagePreprocessDetail() {
    return Positioned(
      bottom: 0,
      left: 12,
      right: 12,
      top: 0,
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(imageDes[_currentIndex],
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700)))),
    );
  }

  Positioned imagePreprocessBox() {
    return Positioned(
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
              width: 220,
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
                  fit: BoxFit.fill,
                  errorBuilder: (BuildContext context, Object exception,
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
    );
  }

  Text TitlePage() {
    return Text(
      "Hasil deteksi wajah",
      style: TextStyle(
          fontSize: 28, fontFamily: 'Urbanist', fontWeight: FontWeight.w700),
    );
  }

  Container TopDecoration() {
    return Container(
      alignment: Alignment.topRight,
      child: SvgPicture.asset(
        "Assets/Svgs/hiasan_atas.svg",
      ),
    );
  }
}