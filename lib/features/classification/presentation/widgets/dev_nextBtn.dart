import 'package:face_shape/widgets/custom_media2.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class DevNextButton extends StatelessWidget {
  final String isi;
  final Widget page;
  const DevNextButton({
    super.key,
    required this.isi,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 10,
      child: CustomButton2(
        isi: isi,
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: page,
            ),
          );
        },
      ),
    );
  }
}
