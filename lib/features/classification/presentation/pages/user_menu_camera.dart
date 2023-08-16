import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:face_shape/features/classification/domain/usecases/upload_image.dart';
import 'package:face_shape/features/classification/presentation/pages/user_menu_page.dart';
import 'package:face_shape/features/classification/presentation/pages/user_menu_result.dart';
import 'package:face_shape/features/classification/presentation/widgets/bottom_decoration.dart';
import 'package:face_shape/features/classification/presentation/widgets/loading_widget.dart';
import 'package:face_shape/features/classification/presentation/widgets/no_face_detection_widget.dart';
import 'package:face_shape/features/classification/presentation/widgets/subtitle_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/title_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/top_decoration.dart';
import 'package:face_shape/features/classification/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;
  bool _isFrontCamera = false;
  bool _isFlashOn = false;
  bool _isLoading = false;
  late CameraController controller;
  String? filePath;

  void _toggleCameraDirection() async {
    final lensDirection =
        _isFrontCamera ? CameraLensDirection.back : CameraLensDirection.front;
    final cameras = await availableCameras();
    final newCamera =
        cameras.firstWhere((camera) => camera.lensDirection == lensDirection);
    await _controller.dispose();
    _controller = CameraController(newCamera, ResolutionPreset.medium);
    await _controller.initialize();
    setState(() {
      _isFrontCamera = !_isFrontCamera;
    });
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[1], ResolutionPreset.medium);
    await _controller.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  void _toggleFlash() {
    // Ubah nilai _isFlashOn menjadi true atau false
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
    // Ubah flash mode sesuai dengan nilai _isFlashOn
    if (_isFlashOn) {
      _controller.setFlashMode(FlashMode.torch);
    } else {
      _controller.setFlashMode(FlashMode.off);
    }
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

    return Scaffold(
        body: Stack(children: [
      SizedBox(
        width: size.width,
        height: size.height,
        child: Column(children: [
          topMenu(context),
          const SizedBox(height: 15),
          const TitleApp(
            textTitle: "Deteksi muka",
          ),
          const SizedBox(height: 10),
          const SubTitileApp(
              text:
                  "Arahkan muka pada kamera lalu tekan icon kamera yang ada di tengah untuk menangkap gambar"),
          const SizedBox(height: 20),
          MainFeature(),
          const SizedBox(height: 15),
          buttonDetection(filePath, context),
          const SizedBox(height: 10),
          const Spacer(),
          const BottomDecoration(),
        ]),
      ),
      LoadingPageWidget(isLoading: _isLoading),
    ]));
  }

  CustomButton buttonDetection(String? filePath, BuildContext context) {
    return CustomButton(
      onTap: () async {
        setState(() {
          _isLoading = true;
        });

        final uploadImage = UploadImage();
        bool isSuccess = await uploadImage.call(filePath!);
        if (isSuccess == true) {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: const ReportScreen(),
            ),
          );
        } else {
          NoFaceDetection(context);
          setState(() {
            _isLoading = false;
          });
        }
      },
      text: "Deteksi",
      imageAsset: "Assets/Icons/face-recognition.png",
      width: 40,
      height: 40,
    );
  }

  Container MainFeature() {
    return Container(
        width: 280,
        height: 350,
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
                            aspectRatio: 1.0 / 1.0,
                            child: CameraPreview(_controller),
                          ),
                        )
                      : Container(),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                faceLine(),
              ],
            ),
            Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 45),
                  CameraDirectionSettings(),
                  TakePicture(),
                  FlashSettings(),
                  SizedBox(width: 45),
                ],
              ),
            ),
          ],
        ));
  }

  CustomBackButton topMenu(BuildContext context) {
    return CustomBackButton(onTap: () {
      Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: const UserMenuPage()),
      );
    });
  }

  GestureDetector TakePicture() {
    return GestureDetector(
        onTap: () async {
          final directory = await getExternalStorageDirectory();
          setState(() {
            filePath = path.join(
              directory!.path,
              '${DateTime.now()}.png',
            );
          });

          XFile picture = await _controller.takePicture();
          picture.saveTo(filePath!);

          print("filepath : " + filePath!);

          AwesomeDialog(
            context: context,
            title: "Gambar tersimpan",
            desc:
                "Gambar sudah tersimpan silahkan klik tombol deteksi untuk melakukan proses deteksi",
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            btnOkOnPress: () {},
            body: Container(
              child: Column(
                children: [
                  Image.file(
                    File(filePath!),
                    width: 230,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Gambar sudah tersimpan silahkan klik tombol deteksi untuk melakukan proses deteksi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          )..show();
        },
        child: SvgPicture.asset("Assets/Svgs/camera_take.svg"));
  }

  GestureDetector FlashSettings() {
    return GestureDetector(
      onTap: () {
        // fungsi ketika gambar ditekan
        _toggleFlash();
      },
      child: SvgPicture.asset(
        _isFlashOn ? "Assets/Svgs/flash_off.svg" : "Assets/Svgs/flash_on.svg",
      ),
    );
  }

  GestureDetector CameraDirectionSettings() {
    return GestureDetector(
      onTap: () {
        // fungsi ketika gambar ditekan
        _toggleCameraDirection();

        if (_isFrontCamera == false) {
          _isFlashOn = true;
        } else if (_isFrontCamera == true) {
          _isFlashOn = false;
        }
      },
      child: SvgPicture.asset(
        "Assets/Svgs/camera_reverse.svg",
      ),
    );
  }

  Positioned faceLine() {
    return Positioned(
      top: 5,
      left: 40,
      child: SizedBox(
        width: 280,
        child: SvgPicture.asset(
          "Assets/Svgs/face_line.svg",
          height: 250,
        ),
      ),
    );
  }
}
