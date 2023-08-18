import 'package:carousel_slider/carousel_slider.dart';

import 'package:face_shape/core/models/main_menu_att.dart';
import 'package:face_shape/features/classification/presentation/widgets/card_mode.dart';
import 'package:face_shape/features/classification/presentation/widgets/title_page.dart';
import 'package:face_shape/features/training/presentation/pages/dev_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import '../widgets/main_menu_widget.dart';
import 'user_menu_page.dart';

class MenuMode extends StatefulWidget {
  const MenuMode({super.key});

  @override
  State<MenuMode> createState() => _MenuModeState();
}

class _MenuModeState extends State<MenuMode> {
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
            const SizedBox(height: 15),
            const TitleApp(
              textTitle: "Pilih Mode",
            ).animate().slideY(begin: 1, end: 0),
            const SizedBox(height: 10),
            contentImage().animate().fade(duration: 0.5.seconds),
            sliderIndicator(),
            subDescription().animate().slideY(begin: 1, end: 0),
            buttonRow(context)
          ],
        ),
      ),
    );
  }

  Row buttonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            // pindah page
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRightWithFade,
                child: _currentIndex == 0
                    ? const DevMenuPage()
                    : const UserMenuPage(),
              ),
            );
          },
          child: ModeButton(currentIndex: _currentIndex),
        ),
        const SizedBox(width: 10),
        buttonSetting(context),
      ],
    );
  }

  Row sliderIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: MainMenuAtt.imageList.asMap().entries.map((entry) {
        int index = entry.key;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: _currentIndex == index ? 25 : 10,
          height: 10,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            shape: BoxShape.rectangle,
            color: _currentIndex == index ? Colors.black : Colors.grey,
          ),
        );
      }).toList(),
    );
  }

  InkWell buttonSetting(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRightWithFade,
            child: const MenuMode(),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: 75,
        width: 75,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: _currentIndex == 1
              ? const Color.fromARGB(255, 212, 245, 252)
              : const Color.fromARGB(255, 19, 21, 34),
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
    );
  }

  SizedBox contentImage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: CarouselSlider(
        items: MainMenuAtt.imageList.map((image) {
          return CardMode(image: image);
        }).toList(),
        options: CarouselOptions(
          height: 330,
          autoPlayInterval: const Duration(seconds: 3),
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
    );
  }

  Padding subDescription() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(MainMenuAtt.deskripsi[_currentIndex],
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500)),
    );
  }
}
