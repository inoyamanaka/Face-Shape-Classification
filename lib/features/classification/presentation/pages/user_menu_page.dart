import 'dart:io';
import 'package:face_shape/core/di/injection.dart';
import 'package:face_shape/core/router/routes.dart';
import 'package:face_shape/features/classification/data/models/request/upload_image_model.dart';
import 'package:face_shape/features/classification/presentation/bloc/classification_bloc.dart';
import 'package:face_shape/features/classification/presentation/widgets/bottom_decoration.dart';
import 'package:face_shape/features/classification/presentation/widgets/custom_media.dart';
import 'package:face_shape/features/classification/presentation/widgets/dialogue.dart';
import 'package:face_shape/features/classification/presentation/widgets/subtitle_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/title_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/top_decoration.dart';
import 'package:face_shape/features/classification/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:face_shape/features/classification/presentation/widgets/loading.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserMenuPage extends StatefulWidget {
  const UserMenuPage({super.key});

  @override
  State<UserMenuPage> createState() => _UserMenuPageState();
}

class _UserMenuPageState extends State<UserMenuPage> {
  late File image;
  String? filePath;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width; // lebar layar
    final double height = size.height; // tinggi layar
    final uploadBloc = sl<ClassificationBlocUpload>();

    return BlocProvider(
      create: (context) => uploadBloc,
      child: ScreenUtilInit(
        builder: (context, child) => Scaffold(
          body: WillPopScope(
            onWillPop: () async {
              Get.toNamed(Routes.menu);
              return false;
            },
            child: BlocConsumer<ClassificationBlocUpload,
                UploadClassificationState>(
              bloc: uploadBloc,
              listener: (context, state) {
                if (state is UploadClassificationFailure) {
                  Get.toNamed(Routes.userResult);
                }
                if (state is UploadClassificationSuccess) {
                  if (state.imageEntity.message == "File failed to uploaded") {
                    noFaceDetection(context);
                  } else {
                    Get.toNamed(Routes.userResult);
                  }
                }
              },
              builder: (context, state) {
                if (state is UploadClassificationLoading) {
                  return const LoadingOverlay(
                    isLoading: true,
                    text: "Mohon tunggu sebentar.....",
                  );
                }
                return Stack(children: [
                  SizedBox(
                    width: width,
                    height: height,
                    child: Column(children: [
                      CustomBackButton(
                        onTap: () {
                          Get.toNamed(Routes.menu);
                        },
                      ),
                      SizedBox(height: 15.h),
                      const TitleApp(textTitle: 'Pilih media'),
                      SizedBox(height: 10.h),
                      const SubTitileApp(
                              text:
                                  "Tentukan pilihan menggunakan gambar galeri atau foto media")
                          .animate()
                          .slideY(begin: 1, end: 0),
                      SizedBox(height: 25.h),
                      CostumMedia(
                        onTap: () async {
                          final picker = ImagePicker();
                          final pickedFile = await picker.pickImage(
                              source: ImageSource.gallery);
                          uploadBloc.add(UploadEvent(
                              filepath:
                                  UploadImageModel(message: pickedFile!.path)));
                        },
                        text: "Gallery",
                        imageAsset: 'Assets/Images/gallery.jpg',
                      ).animate().slideY(begin: 1, end: 0),
                      SizedBox(height: 15.h),
                      cameraMenu(context).animate().slideY(begin: 1, end: 0),
                      SizedBox(height: 35.h),
                      panduanButton(context).animate().slideY(begin: 1, end: 0),
                      const Spacer(),
                      const BottomDecoration(),
                    ]),
                  ),
                ]);
              },
            ),
          ),
        ),
      ),
    );
  }

  CustomButton panduanButton(BuildContext context) {
    return CustomButton(
      onTap: () {
        Get.toNamed(Routes.userGuide);
      },
      text: "Panduan",
      imageAsset: "Assets/Icons/file.png",
      width: 40.w,
      height: 40.h,
    );
  }

  CostumMedia cameraMenu(BuildContext context) {
    return CostumMedia(
      onTap: () {
        Get.toNamed(Routes.userCamera);
      },
      text: "Camera",
      imageAsset: 'Assets/Images/camera.jpg',
    );
  }
}
