import 'package:carousel_slider/carousel_slider.dart';
import 'package:face_shape/features/classification/data/models/main_menu_att.dart';
import 'package:face_shape/features/classification/presentation/pages/user_menu_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/top_decoration.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);

class ImageDetail extends StatefulWidget {
  const ImageDetail({super.key});

  @override
  State<ImageDetail> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Column(
      children: [
        Container(
          height: 300,
          width: 330,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: CarouselSlider(
            items: MainMenuAtt.imageListGuide
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
                // currentIndex = index;

                setState(() {
                  _currentIndexNotifier.value = index;
                });
                print(_currentIndexNotifier.value);
              },
            ),
          ),
        ),
        SliderIndicator(),
      ],
    );
  }
}

Row SliderIndicator() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: MainMenuAtt.imageListGuide.asMap().entries.map((entry) {
      int index = entry.key;
      print(_currentIndexNotifier.value);

      return Container(
        width: 10,
        height: 10,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              _currentIndexNotifier.value == index ? Colors.black : Colors.grey,
        ),
      );
    }).toList(),
  );
}

Container ImageCaption() {
  return Container(
    width: 300,
    height: 70,
    child: Center(
      child: Text(
        MainMenuAtt.deskripsiGuide[_currentIndexNotifier.value],
        textAlign:
            TextAlign.center, // indeks dari elemen yang ingin ditampilkan
        style: TextStyle(
            fontSize: 16, fontFamily: 'Urbanist', fontWeight: FontWeight.w300),
      ),
    ),
  );
}

Center SubDescriptionGuide() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        "Tentukan pilihan menggunakan gambar galeri atau foto kamera",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16, fontFamily: 'Urbanist', fontWeight: FontWeight.w300),
      ),
    ),
  );
}

Text TitlePage() {
  return Text(
    "Panduan",
    style: TextStyle(
        fontSize: 28, fontFamily: 'Urbanist', fontWeight: FontWeight.w700),
  );
}

Container TopMenu(BuildContext context) {
  return Container(
      alignment: Alignment.topRight,
      child: CustomBackButton(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: UserMenuPage(),
            ),
          );
        },
      ));
}
