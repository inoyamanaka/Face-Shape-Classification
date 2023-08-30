// ignore_for_file: non_constant_identifier_names

import 'package:face_shape/core/di/injection.dart';
import 'package:face_shape/core/router/routes.dart';
import 'package:face_shape/features/classification/presentation/pages/main_menu_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/custom_button.dart';
import 'package:face_shape/features/classification/presentation/widgets/loading.dart';
import 'package:face_shape/features/classification/presentation/widgets/top_decoration.dart';
import 'package:face_shape/features/training/presentation/bloc/training_bloc.dart';
import 'package:face_shape/features/training/presentation/widgets/custom_image_slide.dart';
import 'package:face_shape/features/training/presentation/widgets/loading_train.dart';
import 'package:face_shape/features/training/presentation/widgets/title_train.dart';
import 'package:face_shape/widgets/costum_hasil_deskripsi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shimmer/shimmer.dart';

class TrainResultPage extends StatefulWidget {
  const TrainResultPage({super.key});

  @override
  State<TrainResultPage> createState() => _TrainResultPageState();
}

final trainBloc = sl<TrainBloc>();
List<String> imageUrlsCrop = [];
List<String> imageUrlsLandmark = [];
List<String> imageUrlsExtract = [];
List<int> jumlahData = [];

class _TrainResultPageState extends State<TrainResultPage> {
  @override
  void initState() {
    super.initState();
    trainBloc.add(GetInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    return ScreenUtilInit(
      builder: (context, child) => Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            Get.offAllNamed(Routes.trainVerif);
            return false;
          },
          child: BlocProvider<TrainBloc>(
            create: (context) => trainBloc,
            child:
                BlocBuilder<TrainBloc, TrainState>(builder: (context, state) {
              if (state is GetInfoStateLoading) {
                return const LoadingOverlayTrain(
                  text: 'Data Preprocessing.....',
                );
              }
              if (state is GetInfoStateSuccess) {
                jumlahData = [
                  state.result.testingCounts[6],
                  state.result.trainingCounts[6]
                ];
                trainBloc.add(GetImagePrepEvent());
              }
              if (state is GetImagePrepStateLoading) {
                return const LoadingOverlayTrain(
                  text: 'Data Preprocessing.....',
                );
              }
              if (state is GetImagePrepStateSuccess) {
                // List<String> imageUrlsCrop = state.result.faceLandmark;
                imageUrlsLandmark = state.result.faceLandmark;
                imageUrlsExtract = state.result.landmarkExtraction;
                trainBloc.add(GetTrainResultEvent());
              }
              if (state is GetTrainResultStateLoading) {
                return const LoadingOverlayTrain(
                  text: 'Training Model....',
                );
              }
              if (state is GetTrainResultStateSuccess) {
                return Column(
                  children: [
                    SizedBox(
                        height: height,
                        child: Stack(children: [
                          Column(
                            children: [
                              SizedBox(
                                  height: height * 0.99,
                                  child: SingleChildScrollView(
                                      child: Column(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        backButtonVerif(context),
                                        const SizedBox(height: 15),
                                        const TitlePage(
                                          text: 'Model Result',
                                        ),
                                        const SizedBox(height: 15),
                                        const TitlePage(
                                          text: "Facial Landmark",
                                        ),
                                        facialLandmarkImage(imageUrlsLandmark),
                                        const SizedBox(height: 15),
                                        const TitlePage(
                                          text: "Landmark Extraction",
                                        ),
                                        landmarkExtractionImage(
                                            imageUrlsExtract),
                                        const SizedBox(height: 15),
                                        // AccurationTitle(),
                                        const SizedBox(height: 10),
                                        trainingResult(state.result.trainAcc,
                                            jumlahData[1]),
                                        const SizedBox(height: 15),
                                        testingResult(
                                            state.result.valAcc, jumlahData[0]),
                                        const SizedBox(height: 15),
                                        const TitlePage(
                                          text: "Plot Akurasi",
                                        ),
                                        const SizedBox(height: 15),
                                        accurationGraphic(state.result.plotAcc),
                                        const SizedBox(height: 15),
                                        const TitlePage(
                                          text: "Plot Loss",
                                        ),
                                        const SizedBox(height: 15),
                                        lossGraphic(state.result.plotLoss),
                                        const SizedBox(height: 15),
                                        const TitlePage(
                                          text: "Confusion Matrix",
                                        ),
                                        const SizedBox(height: 15),
                                        cFGraphic(state.result.conf),
                                        const SizedBox(height: 35),
                                        saveModelButton(width),
                                        const SizedBox(height: 100),
                                      ],
                                    ),
                                  ]))),
                              const SizedBox(height: 5),
                            ],
                          ),
                          const LoadingOverlay(
                            text: "Mohon Tunggu Sebentar...",
                            isLoading: false,
                          )
                        ])),
                  ],
                );
              }
              return const SizedBox();
            }),
          ),
        ),
      ),
    );
  }

  CustomBackButton backButtonVerif(BuildContext context) {
    return CustomBackButton(
      onTap: () {},
    );
  }

  Positioned backButtonDev(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 10,
      child: CustomButton(
        onTap: () {
          // deleteImgs();
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: const MenuMode(),
            ),
          );
        },
        text: "main menu",
        imageAsset: "Assets/Icons/main-menu.png",
        width: 50,
        height: 40,
      ),
    );
  }

  Center saveModelButton(double width) {
    return Center(
      child: InkWell(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          height: 50,
          width: width * 0.8,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 19, 21, 34),
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 25,
              ),
              Image.asset(
                "Assets/Icons/save.png",
                width: 30,
                height: 30,
              ),
              const SizedBox(
                width: 35,
              ),
              const Text(
                "Save model",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Urbanist',
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center cFGraphic(conf) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: 280,
        width: 280,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 217, 217, 217),
            border: Border.all(color: Colors.black)),
        child: PhotoView(
          initialScale: PhotoViewComputedScale.contained * 0.8,
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          maxScale: PhotoViewComputedScale.contained * 1.25,
          minScale: PhotoViewComputedScale.contained,
          imageProvider: NetworkImage(
            '$conf',
          ),
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            // Jika gambar gagal dimuat karena kesalahan, tampilkan efek shimmer sebagai gantinya
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.grey[300],
              ),
            );
          },
        ),
      ),
    );
  }

  Center lossGraphic(plotLoss) {
    return Center(
      child: Container(
        height: 220,
        width: 280,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 217, 217, 217),
            border: Border.all(color: Colors.black)),
        child: PhotoView(
          initialScale: PhotoViewComputedScale.contained * 0.8,
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          maxScale: PhotoViewComputedScale.contained * 1.25,
          minScale: PhotoViewComputedScale.contained,
          imageProvider: NetworkImage(
            '$plotLoss',
          ),
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            // Jika gambar gagal dimuat karena kesalahan, tampilkan efek shimmer sebagai gantinya
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.grey[300],
              ),
            );
          },
        ),
      ),
    );
  }

  Center accurationGraphic(plotAcc) {
    return Center(
      child: Container(
        height: 220,
        width: 280,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 217, 217, 217),
            border: Border.all(color: Colors.black)),
        child: PhotoView(
          initialScale: PhotoViewComputedScale.contained * 1.0,
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          maxScale: PhotoViewComputedScale.contained * 1.0,
          minScale: PhotoViewComputedScale.contained * 1.0,
          imageProvider: NetworkImage(
            '$plotAcc',
          ),
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            // Jika gambar gagal dimuat karena kesalahan, tampilkan efek shimmer sebagai gantinya
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.grey[300],
              ),
            );
          },
        ),
      ),
    );
  }

  Center testingResult(persentase_test, testingValues) {
    return Center(
        child: HasilAkurasiCard("Hasil Laporan Testing", "Testing",
            (persentase_test * 100).toInt(), testingValues));
  }

  Center trainingResult(persentase_train, trainingValues) {
    return Center(
        child: HasilAkurasiCard("Hasil Laporan Training", "Training",
            (persentase_train * 100).toInt(), trainingValues));
  }

  ImageSlide landmarkExtractionImage(List<String> imageurlsLandmark) {
    return ImageSlide(imageList: imageurlsLandmark);
  }

  ImageSlide facialLandmarkImage(List<String> imageurlsLandmark) {
    return ImageSlide(imageList: imageurlsLandmark);
  }
}
