import 'package:flutter/material.dart';
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
      const Text(
        "Laporan hasil deteksi",
        style: TextStyle(
            fontSize: 18, fontFamily: 'Urbanist', fontWeight: FontWeight.w700),
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 33),
            child: SizedBox(
              width: 150,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 16.0, color: Colors.black),
                  children: [
                    const TextSpan(
                        text:
                            'Berdasarkan hasil deteksi bentuk wajah yang anda miliki adalah bentuk wajah jenis ',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w300)),
                    TextSpan(
                        text: '$_bentuk_wajah',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          CircularPercentIndicator(
            radius: 50.0,
            lineWidth: 12.0,

            percent: (_persentase /
                100), // nilai progress saat ini (dalam bentuk desimal)
            center: Text("$_persentase%"), // teks persentase
            progressColor: const Color.fromARGB(255, 80, 101, 252),
          ),
        ],
      ),
    ]);
  }
}
