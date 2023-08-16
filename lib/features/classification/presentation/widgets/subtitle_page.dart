import 'package:face_shape/config/config.dart';
import 'package:flutter/material.dart';

class SubTitileApp extends StatelessWidget {
  const SubTitileApp({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(text,
            textAlign: TextAlign.center, style: MyFonts().primary300),
      ),
    );
  }
}
