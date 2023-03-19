import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;

  const LoadingOverlay({Key? key, required this.isLoading}) : super(key: key);

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
              width: 230,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitSquareCircle(
                    color: Color.fromARGB(255, 80, 101, 252),
                    size: 50.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Mohon Tunggu Sebentar..",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w300),
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
