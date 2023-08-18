import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPageWidget extends StatelessWidget {
  final bool isLoading;
  const LoadingPageWidget({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              // borderRadius: BorderRadius.circular(10.0), // set border rounder
              color: Colors.black,
            ),
            child: const ModalBarrier(
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
              child: const Column(
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
