import 'package:flutter/material.dart';

class FaceCroppingCard extends StatefulWidget {
  final String deskripsi;
  const FaceCroppingCard({Key? key, required this.deskripsi}) : super(key: key);

  @override
  _FaceCroppingCardState createState() => _FaceCroppingCardState();
}

class _FaceCroppingCardState extends State<FaceCroppingCard> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    ;
    return Center(
      child: Container(
        height: 330,
        width: width * 0.8,
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            color: Color.fromARGB(255, 217, 217, 217),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 120,
            width: width * 0.8,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "Assets/Images/face_cropping.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 140,
            width: width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.deskripsi,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Color.fromARGB(255, 19, 21, 34),
                    fontSize: 15,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 30,
                width: 75,
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    color: Color.fromARGB(255, 217, 217, 217),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Switch(
                  value: _switchValue,
                  onChanged: (bool value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                  activeColor: Colors.green,
                  inactiveTrackColor: Colors.red,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          )
        ]),
      ),
    );
  }
}
