import 'package:carousel_slider/carousel_slider.dart';
import 'package:face_shape/Scenes/Tampilan_menu.dart';
import 'package:face_shape/Scenes/Tampilan_model_result.dart';
import 'package:face_shape/Scenes/Tampilan_select_model.dart';
import 'package:face_shape/Scenes/Tampilan_upload_dataset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class MenuMode extends StatefulWidget {
  const MenuMode({super.key});

  @override
  State<MenuMode> createState() => _MenuModeState();
}

class _MenuModeState extends State<MenuMode> {
  final List<String> imageList = [
    "Assets/Images/mode_pengembang.png",
    "Assets/Images/mode_pengguna.png",
  ];

  final List<String> deskripsi = [
    "mode pengembang digunakan untuk mengembangkan model AI",
    "mode pengguna digunakan untuk melakukan klasifikasi bentuk wajah"
  ];

  final List<String> mode = ["Mode Pengembang", "Mode Pengguna"];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Column(
          children: [
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
              "Pilih mode",
              style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              // atur lebar, tinggi, dan warna latar belakang container sesuai kebutuhan
              width: 300,
              height: 400,
              // color: Colors.amber,
              child: CarouselSlider(
                items: imageList.map((image) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      border: Border.all(
                        color: Colors.black, // warna border
                        width: 2, // ketebalan border
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Image.asset(
                        image,
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 330,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageList.asMap().entries.map((entry) {
                int index = entry.key;
                // String image = entry.value;
                return AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: _currentIndex == index ? 25 : 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    shape: BoxShape.rectangle,
                    color: _currentIndex == index ? Colors.black : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(deskripsi[_currentIndex],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (_currentIndex == 0) {
                      // pindah page
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRightWithFade,
                          child: UploadDataScreen(),
                        ),
                      );
                    } else if (_currentIndex == 1) {
                      // pindah page
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRightWithFade,
                          child: MainMenu(),
                        ),
                      );
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: 75,
                    width: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: _currentIndex == 1
                          ? Color.fromARGB(255, 212, 245, 252)
                          : Color.fromARGB(255, 19, 21, 34),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          mode[_currentIndex],
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Urbanist',
                            color: _currentIndex == 1
                                ? Color.fromARGB(255, 19, 21, 34)
                                : Color.fromARGB(255, 212, 245, 252),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    if (_currentIndex == 0) {
                      // pindah page
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRightWithFade,
                          child: SelectModelScreen(),
                        ),
                      );
                    } else if (_currentIndex == 1) {
                      // pindah page
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRightWithFade,
                          child: SelectModelScreen(),
                        ),
                      );
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: 75,
                    width: 75,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: _currentIndex == 1
                          ? Color.fromARGB(255, 212, 245, 252)
                          : Color.fromARGB(255, 19, 21, 34),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            _currentIndex == 0
                                ? "Assets/Icons/user(1).png"
                                : "Assets/Icons/user(2).png",
                            width: 45,
                            height: 45,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
