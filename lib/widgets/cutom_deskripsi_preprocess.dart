import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:face_shape/Datas/url_host.dart';

class FaceCroppingCard extends StatefulWidget {
  final String deskripsi;
  final String gambar;
  final String tahap;

  const FaceCroppingCard({
    Key? key,
    required this.deskripsi,
    required this.gambar,
    required this.tahap,
  }) : super(key: key);

  @override
  _FaceCroppingCardState createState() => _FaceCroppingCardState();
}

class _FaceCroppingCardState extends State<FaceCroppingCard> {
  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        height: 350,
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
                  widget.gambar,
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
                  onChanged: (bool value) async {
                    setState(() {
                      if (_switchValue == false) {
                        _switchValue = true;
                      } else if (_switchValue == true) {
                        _switchValue = false;
                      }

                      // Mengirim status switch ke server Flask Python
                    });
                    final response = await http.post(
                      Uri.parse('${ApiUrl.Url}/${widget.tahap}'),
                      body: {'status': _switchValue.toString()},
                    );
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
