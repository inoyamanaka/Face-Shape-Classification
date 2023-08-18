import 'package:face_shape/core/models/main_menu_att.dart';
import 'package:face_shape/core/router/routes.dart';
import 'package:face_shape/features/classification/presentation/widgets/bottom_decoration.dart';
import 'package:face_shape/features/classification/presentation/widgets/image_slider_guide.dart';
import 'package:face_shape/features/classification/presentation/widgets/subtitle_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/title_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/top_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class PanduanScreen extends StatefulWidget {
  const PanduanScreen({super.key});

  @override
  State<PanduanScreen> createState() => _PanduanScreenState();
}

ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);

class _PanduanScreenState extends State<PanduanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Get.toNamed(Routes.userMenu);
          return false;
        },
        child: Column(children: [
          topMenu(context),
          const SizedBox(height: 15),
          const TitleApp(textTitle: "Panduan")
              .animate()
              .slideY(begin: 1, end: 0),
          const SizedBox(height: 10),
          subDescriptionGuide().animate().slideY(begin: 1, end: 0),
          const SizedBox(height: 10),
          const ImageDetail()
              .animate()
              .fade(duration: GetNumUtils(0.5).seconds),
          const SizedBox(height: 10),
          imageCaption().animate().slideY(begin: 1, end: 0),
          const Spacer(),
          const BottomDecoration(),
        ]),
      ),
    );
  }

  CustomBackButton topMenu(BuildContext context) {
    return CustomBackButton(onTap: () {
      Get.toNamed(Routes.userMenu);
    });
  }

  Center subDescriptionGuide() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SubTitileApp(
          text: "Tentukan pilihan menggunakan gambar galeri atau foto kamera",
        ),
      ),
    );
  }

  SizedBox imageCaption() {
    return SizedBox(
      width: 300,
      height: 70,
      child: Center(
        child: Text(
          MainMenuAtt.deskripsiGuide[_currentIndexNotifier.value],
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
