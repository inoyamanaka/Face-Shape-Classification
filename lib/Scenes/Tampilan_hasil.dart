import 'package:carousel_slider/carousel_slider.dart';
import 'package:face_shape/Scenes/Tampilan_menu.dart';
import 'package:face_shape/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final List<String> imageList = [
    // daftar widget yang ditampilkan dalam carousel
    "Assets/Images/splashscreen.jpg",
    "Assets/Images/splashscreen.jpg",
    "Assets/Images/splashscreen.jpg",
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height * 0.85,
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
                          height: 200,
                          child: CarouselSlider(
                            items: imageList
                                .map((image) => Image.asset(image))
                                .toList(),
                            options: CarouselOptions(
                              height: 200,
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
                    ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map((entry) {
                      int index = entry.key;
                      String image = entry.value;
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
                    color: Color.fromARGB(255, 217, 217, 217),
                    height: 200,
                    width: 300,
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
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    color: Color.fromARGB(255, 217, 217, 217),
                    height: 200,
                    width: 300,
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
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    color: Color.fromARGB(255, 217, 217, 217),
                    height: 250,
                    width: 300,
                    child: Column(children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Rekomendasi gaya rambut",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 180,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromARGB(255, 80, 101, 252),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                height: 180,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromARGB(255, 80, 101, 252),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                height: 180,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromARGB(255, 80, 101, 252),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 15,
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
