import 'package:camera/camera.dart';
import 'package:face_shape/Scenes/Tampilan_awal.dart';
import 'package:face_shape/Scenes/Tampilan_hasil.dart';
import 'package:face_shape/Scenes/Tampilan_menu.dart';
import 'package:face_shape/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[0], ResolutionPreset.medium);
    await _controller.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;

    return Scaffold(
        body: Container(
      width: width,
      height: height,
      child: Column(children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    // Tindakan yang akan dilakukan saat gambar ditekan
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: MainMenu()),
                      // ),
                    );
                  },
                  child: Image.asset(
                    "Assets/Icons/back.png",
                    width: 35,
                    height: 35,
                  ),
                ),
              ),
              SvgPicture.asset(
                "Assets/Svgs/hiasan_atas.svg",
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text(
          "Deteksi Muka",
          style: TextStyle(
              fontSize: 28,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 10),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Arahkan muka pada kamera lalu tunggu sesaat hingga kamera mendeteksi dan menangkap gambar.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Container(
          width: 336,
          height: 346,
          child: Stack(
            children: [
              Positioned(
                  bottom: 35,
                  left: 0,
                  right: 0,
                  top: 5,
                  child: Container(
                    height: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromARGB(255, 217, 217, 217),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: _isCameraInitialized
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: CameraPreview(_controller),
                            ),
                          )
                        : Container(),
                  )),
              Positioned(
                bottom: 5,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: 45),
                    SvgPicture.asset("Assets/Svgs/camera_reverse.svg"),
                    SvgPicture.asset("Assets/Svgs/camera_take.svg"),
                    SvgPicture.asset("Assets/Svgs/camera_reverse.svg"),
                    SizedBox(width: 45),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        CustomButton(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  child: ReportScreen()),
              // ),
            );
          },
          text: "Deteksi",
          imageAsset: "Assets/Icons/face-recognition.png",
          width: 40,
          height: 40,
        ),
        SizedBox(height: 10),
        Container(
          height: 70,
          alignment: Alignment.bottomLeft,
          child: SvgPicture.asset(
            "Assets/Svgs/hiasan_bawah.svg",
          ),
        ),
      ]),
    ));
  }
}
