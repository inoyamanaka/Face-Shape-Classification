import 'package:face_shape/features/classification/presentation/pages/user_menu_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/bottom_decoration.dart';
import 'package:face_shape/features/classification/presentation/widgets/guide_menu_widget.dart';
import 'package:face_shape/features/classification/presentation/widgets/user_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PanduanScreen extends StatefulWidget {
  const PanduanScreen({super.key});

  @override
  State<PanduanScreen> createState() => _PanduanScreenState();
}

class _PanduanScreenState extends State<PanduanScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => UserMenuPage()));
          return false;
        },
        child: Container(
          child: Column(children: [
            TopMenu(context),
            SizedBox(height: 15),
            TitlePage().animate().slideY(begin: 1, end: 0),
            SizedBox(height: 10),
            SubDescriptionGuide().animate().slideY(begin: 1, end: 0),
            SizedBox(height: 10),
            ImageDetail().animate().fade(duration: 0.5.seconds),
            SizedBox(height: 10),
            ImageCaption().animate().slideY(begin: 1, end: 0),
            Spacer(),
            BottomDecoration(),
          ]),
        ),
      ),
    );
  }
}
