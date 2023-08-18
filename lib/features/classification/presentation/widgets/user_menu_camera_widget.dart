// import 'package:camera/camera.dart';
// import 'package:face_shape/features/classification/domain/usecases/upload_image.dart';
// import 'package:face_shape/features/classification/presentation/widgets/no_face_detection_widget.dart';
// import 'package:face_shape/features/classification/presentation/widgets/upload_progress.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;

// class CameraMenuWidget extends StatefulWidget {
//   final String? filePath;
//   // final CameraController controller;
//   const CameraMenuWidget({super.key, required this.filePath});

//   @override
//   State<CameraMenuWidget> createState() => _CameraMenuWidgetState();
// }

// class _CameraMenuWidgetState extends State<CameraMenuWidget> {
//   bool isCameraInitialized = false;
//   bool isFrontCamera = false;
//   bool isFlashOn = false;
//   bool isLoading = false;

//   // CameraController? _controller1;
//   late CameraController _controller1;
//   late CameraController _controller2;

//   List<CameraDescription> _cameras = [];
//   String? filePath;

//   void _toggleFlash() {
//     // Ubah nilai _isFlashOn menjadi true atau false
//     setState(() {
//       isFlashOn = !isFlashOn;
//     });
//     // Ubah flash mode sesuai dengan nilai _isFlashOn
//     if (isFlashOn) {
//       _controller2.setFlashMode(FlashMode.torch);
//     } else {
//       _controller2.setFlashMode(FlashMode.off);
//     }
//   }

//   void _toggleCameraDirection() async {
//     final lensDirection =
//         isFrontCamera ? CameraLensDirection.back : CameraLensDirection.front;
//     final cameras = await availableCameras();
//     final newCamera =
//         cameras.firstWhere((camera) => camera.lensDirection == lensDirection);
//     await _controller2.dispose();
//     _controller2 = CameraController(newCamera, ResolutionPreset.medium);
//     await _controller2.initialize();
//     setState(() {
//       isFrontCamera = !isFrontCamera;
//     });
//   }

//   Future<void> initCamera() async {
//     // print(_controller2);

//     setState(() async {
//       _cameras = await availableCameras();
//       _controller2 = CameraController(_cameras[1], ResolutionPreset.medium);
//       await _controller2.initialize();
//       isCameraInitialized = true;
//     });
//   }

//   Future<void> _captureImage() async {
//     _cameras = await availableCameras();
//     _controller1 = CameraController(_cameras[1], ResolutionPreset.medium);
//     await _controller1.initialize();
//     print(_controller2);
//     try {
//       final directory = await getExternalStorageDirectory();
//       filePath = path.join(
//         directory!.path,
//         '${DateTime.now()}.png',
//       );

//       XFile picture = await _controller1.takePicture();
//       await picture.saveTo(filePath!);
//       print("Image saved to: $filePath");
//       final uploadImage = UploadImage();
//       bool isSuccess = await uploadImage.call(filePath!);

//       isSuccess == true ? SuccesUpload(context) : NoFaceDetection(context);
//     } catch (e) {
//       print("Error while capturing or saving image: $e");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     isCameraInitialized = true;
//     initCamera();
//   }

//   @override
//   void dispose() {
//     // _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         SizedBox(width: 45),
//         CameraSettings(),
//         TakePicture(widget.filePath, context),
//         FlashSettings(),
//         SizedBox(width: 45),
//       ],
//     );
//   }

//   GestureDetector TakePicture(String? filePath, BuildContext context) {
//     return GestureDetector(
//         onTap: () async {
//           _captureImage();
//           // final picker = ImagePicker();
//           // final pickedFile = await picker.pickImage(source: ImageSource.camera);
//           // String path = pickedFile!.path;

//           final uploadImage = UploadImage();
//           bool isSuccess = await uploadImage.call(filePath!);

//           isSuccess == true
//               ? uploadSuccessImage(context, filePath)
//               : NoFaceDetection(context);
//         },
//         child: SvgPicture.asset("Assets/Svgs/camera_take.svg"));
//   }

//   GestureDetector FlashSettings() {
//     return GestureDetector(
//       onTap: () {
//         // fungsi ketika gambar ditekan
//         // _toggleFlash();
//       },
//       child: SvgPicture.asset(
//         isFlashOn ? "Assets/Svgs/flash_off.svg" : "Assets/Svgs/flash_on.svg",
//       ),
//     );
//   }

//   GestureDetector CameraSettings() {
//     return GestureDetector(
//       onTap: () {
//         // fungsi ketika gambar ditekan
//         _toggleCameraDirection();

//         if (isFrontCamera == false) {
//           isFlashOn = true;
//         } else if (isFrontCamera == true) {
//           isFlashOn = false;
//         }
//       },
//       child: SvgPicture.asset(
//         "Assets/Svgs/camera_reverse.svg",
//       ),
//     );
//   }
// }
