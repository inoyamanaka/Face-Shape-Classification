// ignore_for_file: non_constant_identifier_names

import 'package:face_shape/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    super.key,
    required String bentuk_wajah,
    required double persentase,
  })  : _bentuk_wajah = bentuk_wajah,
        _persentase = persentase;

  final String _bentuk_wajah;
  final double _persentase;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 15),
      Text(
        "Laporan hasil deteksi",
        style: TextStyle(
            fontSize: 18.sp,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w700),
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 33),
            child: SizedBox(
              width: 150.w,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  children: [
                    TextSpan(
                        text:
                            'Berdasarkan hasil deteksi bentuk wajah yang anda miliki adalah bentuk wajah jenis ',
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w300)),
                    TextSpan(
                        text: _bentuk_wajah,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 5.w),
          CircularPercentIndicator(
            radius: 50.0,
            lineWidth: 12.0,
            percent: (_persentase / 100),
            center: Text("$_persentase%"),
            progressColor: MyColors().primary,
          ),
        ],
      ),
    ]);
  }
}
