import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:face_shape/Scenes/Tampilan_hasil.dart';
import 'package:face_shape/Scenes/Tampilan_menu.dart';
import 'package:face_shape/widgets/custom_button.dart';
import 'package:face_shape/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

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

  Future<http.Response> _sendImage(String imagePath) async {
    final url = Uri.parse('http://32b6-139-0-239-34.ngrok.io/upload');

    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', imagePath));
    final response = await request.send();
    if (response.statusCode == 200) {
      final String responseData = await response.stream.bytesToString();
      return http.Response(responseData, 200);
    } else {
      throw Exception('Failed to upload image');
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
    final double height = size.height;
    final double width = size.width;

    String? filePath;

    return Scaffold(
        body: Stack(children: [
      Container(
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
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: MainMenu()),
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
                "Arahkan muka pada kamera lalu tekan button kamera yang ada di tengah untuk menangkap gambar.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
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
                                  aspectRatio: 16.9 / 9.0,
                                  child: CameraPreview(_controller),
                                ),
                              )
                            : Container(),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Positioned(
                        top: 5,
                        left: 40,
                        child: Container(
                          width: 280,
                          // height: 300,
                          child: SvgPicture.asset(
                            "Assets/Svgs/face_line.svg",
                            height: 250,
                          ),
                        ),
                      ),
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
                        GestureDetector(
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
                        ),
                        GestureDetector(
                            onTap: () async {
                              final directory =
                                  await getExternalStorageDirectory();
                              filePath = path.join(
                                directory!.path,
                                '${DateTime.now()}.png',
                              );
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
                            child: SvgPicture.asset(
                                "Assets/Svgs/camera_take.svg")),
                        GestureDetector(
                          onTap: () {
                            // fungsi ketika gambar ditekan
                            _toggleFlash();
                          },
                          child: SvgPicture.asset(
                            _isFlashOn
                                ? "Assets/Svgs/flash_off.svg"
                                : "Assets/Svgs/flash_on.svg",
                          ),
                        ),
                        SizedBox(width: 45),
                      ],
                    ),
                  ),
                ],
              )),
          SizedBox(height: 15),
          CustomButton(
            onTap: () async {
              setState(() {
                _isLoading = true;
              });

              final response = await _sendImage(filePath!);
              if (response.statusCode == 200) {
                final jsonResponse = json.decode(response.body);
                print("response: " + jsonResponse.toString());
                if (jsonResponse['message'] == 'File successfully uploaded') {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: ReportScreen(),
                    ),
                  );
                  // Lakukan sesuatu jika file berhasil di-upload
                } else {
                  AwesomeDialog(
                    context: context,
                    title: "Tidak terdeteksi wajah",
                    body: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Mohon maaf gambar yang anda masukan tidak terdeteksi wajah di dalamnya, mohon untuk memasukkan gambar dengan benar dan sesuai termakasih",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    dialogType: DialogType.error,
                    animType: AnimType.bottomSlide,
                    btnOkColor: Colors.red,
                    btnOkText: "Kembali",
                    btnOkOnPress: () {
                      setState(() {
                        _isLoading = false;
                      });
                    },
                  )..show();
                }
              } else {
                // Handle error uploading image to server
                print('Failed to upload image: ${response}');
              }
            },
            text: "Deteksi",
            imageAsset: "Assets/Icons/face-recognition.png",
            width: 40,
            height: 40,
          ),
          SizedBox(height: 10),
          Spacer(),
          Container(
            height: 70,
            alignment: Alignment.bottomLeft,
            child: SvgPicture.asset(
              "Assets/Svgs/hiasan_bawah.svg",
            ),
          ),
        ]),
      ),
      Visibility(
        visible: _isLoading,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10.0), // set border rounder
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
      ),
    ]));
  }
}
