import 'package:carousel_slider/carousel_slider.dart';
import 'package:face_shape/Scenes/Tampilan_menu.dart';
import 'package:face_shape/widgets/custom_backbtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class PanduanScreen extends StatefulWidget {
  const PanduanScreen({super.key});

  @override
  State<PanduanScreen> createState() => _PanduanScreenState();
}

class _PanduanScreenState extends State<PanduanScreen> {
  final List<String> imageList = [
    // daftar widget yang ditampilkan dalam carousel
    "Assets/Images/panduan1.png",
    "Assets/Images/panduan2.png",
    "Assets/Images/panduan3.png",
  ];

  final List<String> ketList = [
    "Hadapkan wajah sejajar dengan kamera dan fokuskan pada area sekitar wajah saja",
    "Jangan menggunakan foto yang terdapat lebih dari satu orang di dalamnya",
    "Jangan gunakan foto yang di dalamnya terdapat objek yang menghalangi wajah "
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainMenu()));
          return false;
        },
        child: Container(
          child: Column(children: [
            Container(
                alignment: Alignment.topRight,
                child: CustomBackButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: MainMenu(),
                      ),
                    );
                  },
                )),
            SizedBox(
              height: 15,
            ),
            Text(
              "Panduan",
              style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Tentukan pilihan menggunakan gambar galeri atau foto kamera",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 300,
              width: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: CarouselSlider(
                items: imageList
                    .map((image) => Image.asset(
                          image,
                          height: 225,
                          width: 225,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 250,
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
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageList.asMap().entries.map((entry) {
                int index = entry.key;
                // String image = entry.value;
                return Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.black : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 300,
              height: 70,
              child: Center(
                child: Text(
                  ketList[_currentIndex],
                  textAlign: TextAlign
                      .center, // indeks dari elemen yang ingin ditampilkan
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Spacer(),
            Container(
              alignment: Alignment.bottomLeft,
              child: SvgPicture.asset(
                "Assets/Svgs/hiasan_bawah.svg",
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
