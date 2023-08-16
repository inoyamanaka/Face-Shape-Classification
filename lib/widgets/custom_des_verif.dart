import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  final String bentuk_wajah;
  final String jumlah_data;
  const CustomList({
    Key? key,
    required this.bentuk_wajah,
    required this.jumlah_data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "• ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: this.bentuk_wajah,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: RichText(
            text: TextSpan(
              text: "• ",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: "${jumlah_data} Buah Data Gambar",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
