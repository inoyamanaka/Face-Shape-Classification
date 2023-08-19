import 'package:camera/camera.dart';
import 'package:face_shape/config/config.dart';
import 'package:face_shape/core/router/routes.dart';
import 'package:face_shape/features/classification/presentation/widgets/dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'package:face_shape/core/di/injection.dart';
import 'package:face_shape/features/classification/presentation/bloc/classification_bloc.dart';
import 'package:face_shape/features/classification/presentation/widgets/bottom_decoration.dart';
import 'package:face_shape/features/classification/presentation/widgets/custom_button.dart';
import 'package:face_shape/features/classification/presentation/widgets/subtitle_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/title_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/top_decoration.dart';

import '../../data/models/request/upload_image_model.dart';

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
  bool isLoading = false;
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
    final uploadBloc = sl<ClassificationBlocUpload>();

    return BlocProvider(
      create: (context) => uploadBloc,
      child: ScreenUtilInit(
        builder: (context, child) => Scaffold(
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(children: [
              topMenu(context),
              SizedBox(height: 15.h),
              const TitleApp(
                textTitle: "Deteksi muka",
              ),
              SizedBox(height: 10.h),
              const SubTitileApp(
                  text:
                      "Arahkan muka pada kamera lalu tekan icon kamera yang ada di tengah untuk menangkap gambar"),
              SizedBox(height: 20.h),
              mainFeature(),
              SizedBox(height: 15.h),
              BlocConsumer<ClassificationBlocUpload, UploadClassificationState>(
                bloc: uploadBloc,
                listener: (context, state) {
                  // print(state);
                  if (state is UploadClassificationLoading) {}
                  if (state is UploadClassificationFailure) {
                    noFaceDetection;
                  }
                  if (state is UploadClassificationSuccess) {
                    // print(state.imageEntity.message);
                    if (state.imageEntity.message ==
                        "File failed to uploaded") {
                      noFaceDetection(context);
                    } else {
                      Get.toNamed(Routes.userResult);
                    }
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    onTap: () {
                      uploadBloc.add(UploadEvent(
                          filepath: UploadImageModel(message: filePath!)));
                    },
                    text: "Deteksi",
                    imageAsset: "Assets/Icons/face-recognition.png",
                    width: 40.w,
                    height: 40.h,
                  );
                },
              ),
              SizedBox(height: 10.h),
              const Spacer(),
              const BottomDecoration(),
            ]),
          ),
        ),
      ),
    );
  }

  SizedBox mainFeature() {
    return SizedBox(
        width: 280.w,
        height: 320.h,
        child: Stack(
          children: [
            Positioned(
                bottom: 35.h,
                left: 0.w,
                right: 0.w,
                top: 5.h,
                child: Container(
                  height: 320.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: MyColors().third,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.w,
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
            faceLine(),
            Positioned(
              bottom: 5.h,
              left: 0.w,
              right: 0.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 45.w),
                  cameraDirectionSettings(),
                  takePicture(context),
                  flashSettings(),
                  SizedBox(width: 45.w),
                ],
              ),
            ),
          ],
        ));
  }

  CustomBackButton topMenu(BuildContext context) {
    return CustomBackButton(onTap: () {
      Get.toNamed(Routes.userMenu);
    });
  }

  GestureDetector takePicture(BuildContext context) {
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
        await picture.saveTo(filePath!);

        // debugPrint("filepath : ${filePath!}");

        // ignore: use_build_context_synchronously
        takePictureDialog(context, filePath!).show();
      },
      child: SvgPicture.asset("Assets/Svgs/camera_take.svg"),
    );
  }

  GestureDetector flashSettings() {
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

  GestureDetector cameraDirectionSettings() {
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
      top: 15.h,
      left: 20.w,
      right: 20.w,
      child: SizedBox(
        width: 280.w,
        child: SvgPicture.asset(
          "Assets/Svgs/face_line.svg",
          height: 230.h,
        ),
      ),
    );
  }
}
