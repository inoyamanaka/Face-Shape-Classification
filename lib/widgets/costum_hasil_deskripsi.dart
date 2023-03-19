import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HasilAkurasiCard extends StatelessWidget {
  final String _bentuk_wajah;
  final String judul;
  final String mode;
  final int _persentase;

  HasilAkurasiCard(this._bentuk_wajah, this.judul, this.mode, this._persentase);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 19, 21, 34),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            this.judul,
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 33,
                ),
                child: Container(
                  width: 150,
                  child: Text(
                    "Anda mendapatkan akurasi pada data $mode sebesar $_persentase% dari jumlah data Y $_persentase",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                child: CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 12.0,
                  percent: (_persentase /
                      100), // nilai progress saat ini (dalam bentuk desimal)
                  center: Text(
                    "$_persentase%",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ), // teks persentase
                  progressColor: Color.fromARGB(255, 80, 101, 252),
                  backgroundColor: Colors.white,

                  animationDuration: 500,
                  animation: true,
                  // borderColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
