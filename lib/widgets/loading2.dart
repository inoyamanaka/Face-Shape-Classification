import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingOverlay2 extends StatelessWidget {
  final bool isLoading;
  final String text;
  final String name;

  const LoadingOverlay2(
      {Key? key,
      required this.text,
      required this.isLoading,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: ModalBarrier(
              dismissible: false,
              color: Colors.transparent,
            ),
          ),
          Center(
            child: Container(
              width: 250,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpinKitSquareCircle(
                    color: Color.fromARGB(255, 80, 101, 252),
                    size: 50.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 220,
                    child: Text(
                      this.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w300),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
