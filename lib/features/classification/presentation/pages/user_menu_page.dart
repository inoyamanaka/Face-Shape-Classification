import 'package:face_shape/config/config.dart';
import 'package:face_shape/features/classification/presentation/pages/main_menu_page.dart';
import 'package:face_shape/features/classification/presentation/pages/user_menu_camera.dart';
import 'package:face_shape/features/classification/presentation/pages/user_menu_guide.dart';
import 'package:face_shape/features/classification/presentation/widgets/bottom_decoration.dart';
import 'package:face_shape/features/classification/presentation/widgets/custom_media.dart';
import 'package:face_shape/features/classification/presentation/widgets/subtitle_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/title_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/top_decoration.dart';
import 'package:face_shape/features/classification/presentation/widgets/user_menu_widget.dart';
import 'package:face_shape/features/classification/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:face_shape/widgets/loading.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';

class UserMenuPage extends StatefulWidget {
  const UserMenuPage({super.key});

  @override
  State<UserMenuPage> createState() => _UserMenuPageState();
}

class _UserMenuPageState extends State<UserMenuPage> {
  // late File _image;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width; // lebar layar
    final double height = size.height; // tinggi layar

    final MyFonts myFonts = MyFonts();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          setState(() {
            _isLoading = false;
          });

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MenuMode()));
          return false;
        },
        child: Stack(children: [
          Container(
            width: width,
            height: height,
            child: Column(children: [
              Container(child: CustomBackButton(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: MenuMode(),
                    ),
                  );
                },
              )),
              const SizedBox(height: 15),
              const TitleApp(textTitle: 'Pilih media'),
              const SizedBox(height: 10),
              const SubTitileApp(
                      text:
                          "Tentukan pilihan menggunakan gambar galeri atau foto media")
                  .animate()
                  .slideY(begin: 1, end: 0),
              const SizedBox(height: 25),
              GalleryMenu(context).animate().slideY(begin: 1, end: 0),
              const SizedBox(height: 15),
              CameraMenu(context).animate().slideY(begin: 1, end: 0),
              const SizedBox(height: 35),
              PanduanButton(context).animate().slideY(begin: 1, end: 0),
              const Spacer(),
              const BottomDecoration(),
            ]),
          ),
          LoadingOverlay(
              text: "Mohon Tunggu Sebentar...", isLoading: _isLoading)
        ]),
      ),
    );
  }

  CustomButton PanduanButton(BuildContext context) {
    return CustomButton(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRightWithFade,
            child: PanduanScreen(),
          ),
        );
      },
      text: "Panduan",
      imageAsset: "Assets/Icons/file.png",
      width: 40,
      height: 40,
    );
  }

  CostumMedia CameraMenu(BuildContext context) {
    return CostumMedia(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.size,
              alignment: Alignment.center,
              duration: Duration(seconds: 1),
              child: CameraScreen()),
        );
      },
      text: "Camera",
      imageAsset: 'Assets/Images/camera.jpg',
    );
  }

  CostumMedia GalleryMenu(BuildContext context) {
    return CostumMedia(
      onTap: () async {
        await UserMenuWidget().UploadImageWidget(context);
        setState(() {});
      },
      text: "Gallery",
      imageAsset: 'Assets/Images/gallery.jpg',
    );
  }
}
