import 'package:face_shape/config/config.dart';
import 'package:face_shape/core/di/injection.dart';
import 'package:face_shape/core/router/routes.dart';
import 'package:face_shape/features/classification/presentation/widgets/top_decoration.dart';
import 'package:face_shape/features/training/presentation/bloc/training_bloc.dart';
import 'package:face_shape/features/training/presentation/pages/train_menu_preprocess_page.dart';
import 'package:face_shape/features/training/presentation/widgets/loading_train.dart';
import 'package:face_shape/features/training/presentation/widgets/train_custom_button.dart';
import 'package:face_shape/features/training/presentation/widgets/verif_column.dart';
import 'package:face_shape/widgets/custom_des_verif.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class TrainVerifPage extends StatefulWidget {
  const TrainVerifPage({super.key});

  @override
  State<TrainVerifPage> createState() => _TrainVerifPageState();
}

// Fungsi untuk melakukan request ke server Flask

final dataInfoBloc = sl<TrainBloc>();

class _TrainVerifPageState extends State<TrainVerifPage> {
  List<String> results = [];

  @override
  void initState() {
    super.initState();
    dataInfoBloc.add(GetInfoEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width; // lebar layar
    final double height = size.height; // tinggi l

    return ScreenUtilInit(
      builder: (context, child) => BlocProvider(
        create: (context) => dataInfoBloc,
        child: Scaffold(body: BlocBuilder<TrainBloc, TrainState>(
          builder: (context, state) {
            if (state is GetInfoStateLoading) {
              return const LoadingOverlayTrain(
                text: "Mohon Tunggu Sebentar....",
              );
            }
            if (state is GetInfoStateSuccess) {
              return WillPopScope(
                  onWillPop: () async {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TrainPreprocessingPage()),
                    );
                    return false;
                  },
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Stack(children: [
                      Column(children: [
                        SizedBox(
                            height: height * 0.99,
                            width: width,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      backButtonPreprocess(context),
                                      const SizedBox(height: 15),
                                      titlePageVerification()
                                          .animate()
                                          .slideY(begin: 1, end: 0),
                                      const SizedBox(height: 5),
                                      dataDetail(
                                          width,
                                          height,
                                          state.result.trainingCounts,
                                          state.result.testingCounts),
                                      const SizedBox(height: 20),
                                      imagePreprocessDetail(
                                        width,
                                        height,
                                      ).animate().slideY(
                                          begin: 1,
                                          end: 0,
                                          duration: const Duration(
                                              milliseconds: 750)),
                                      const SizedBox(height: 20),
                                      modelParamsDetail(
                                          width,
                                          height,
                                          state.result.optimizer,
                                          state.result.epoch,
                                          state.result.batchSize),
                                      const SizedBox(height: 20),
                                      Center(
                                        child: TrainNextButton(
                                          text: "Train Model",
                                          onTap: () {
                                            Get.toNamed(Routes.trainResult);
                                          },
                                        ),
                                      )
                                    ]))),
                        const SizedBox(height: 5),
                      ]),
                    ]),
                  ));
            }
            return const SizedBox();
          },
        )),
      ),
    );
  }

  Center modelParamsDetail(
      double width, double height, String optimizer, int epoch, int batchSize) {
    return Center(
      child: Column(children: [
        Container(
          width: width * 0.85,
          height: 50,
          color: MyColors().primary,
          child: const Center(
            child: Text("Model Parameter",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700)),
          ),
        ),
        Container(
          width: width * 0.85,
          height: height * 0.15,
          decoration: BoxDecoration(
              color: MyColors().third,
              border: Border.all(color: MyColors().primary)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Daftar parameter model",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomList2(preprocessing: 'Optimizer  : $optimizer'),
                CustomList2(preprocessing: 'Batch Size : $batchSize'),
                CustomList2(preprocessing: 'Epoch      : $epoch'),
              ]),
            ]),
          ),
        ),
        Container(
          width: width * 0.85,
          height: 20,
          color: MyColors().primary,
        ),
      ]),
    );
  }

  Center imagePreprocessDetail(double width, double height) {
    return Center(
      child: Column(children: [
        Container(
          width: width * 0.85,
          height: 50,
          color: MyColors().primary,
          child: const Center(
            child: Text("Image Preprocessing",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700)),
          ),
        ),
        Container(
          width: width * 0.85,
          height: height * 0.15,
          color: MyColors().secondary,
          child: Container(
            alignment: Alignment.topLeft,
            width: width * 0.45,
            height: height * 0.35,
            decoration: BoxDecoration(
                color: MyColors().third,
                border: Border.all(color: MyColors().primary)),
            child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Daftar Image Preprocessing",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500)),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomList2(
                              preprocessing: "Facial Landmark",
                            ),
                            CustomList2(
                              preprocessing: "Landmark Extraction",
                            ),
                          ]),
                    ])),
          ),
        ),
        Container(
          width: width * 0.85,
          height: 20,
          color: MyColors().primary,
        ),
      ]),
    );
  }

  Center dataDetail(
      double width, double height, trainingValues, testingValues) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              trainingDetail(width, height, trainingValues).animate().slideY(
                  begin: 1,
                  end: 0,
                  duration: const Duration(milliseconds: 500)),
              const SizedBox(height: 15),
              testingDetail(width, height, testingValues).animate().slideY(
                  begin: 1, end: 0, duration: const Duration(milliseconds: 750))
            ],
          ),
        ),
      ),
    );
  }

  Column testingDetail(double width, double height, testingValues) {
    return Column(
      children: [
        Container(
          width: width * 0.85,
          height: 50,
          color: MyColors().primary,
          child: const Center(
            child: Text("Testing",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700)),
          ),
        ),
        Container(
          width: width * 0.85,
          height: height * 0.37,
          decoration: BoxDecoration(
              color: MyColors().primary,
              border: Border.all(color: MyColors().primary)),
          child: Container(
            alignment: Alignment.topLeft,
            width: width * 0.45,
            height: height * 0.35,
            color: MyColors().third,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Data testing : ${testingValues[6]}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500)),
                      Column(children: [
                        CustomList(
                          bentuk_wajah: "Diamond",
                          jumlah_data: "${testingValues[0]}",
                        ),
                        CustomList(
                          bentuk_wajah: "Oval",
                          jumlah_data: "${testingValues[2]}",
                        ),
                        CustomList(
                          bentuk_wajah: "Round",
                          jumlah_data: "${testingValues[3]}",
                        ),
                        CustomList(
                          bentuk_wajah: "Square",
                          jumlah_data: "${testingValues[4]}",
                        ),
                        CustomList(
                          bentuk_wajah: "Oblong",
                          jumlah_data: "${testingValues[1]}",
                        ),
                        CustomList(
                          bentuk_wajah: "Triangle",
                          jumlah_data: "${testingValues[5]}",
                        ),
                      ]),
                    ])),
          ),
        ),
        Container(
          width: width * 0.85,
          height: 20,
          color: MyColors().primary,
        ),
      ],
    );
  }

  Column trainingDetail(double width, double height, trainingValues) {
    return Column(
      children: [
        Container(
          width: width * 0.85,
          height: 50,
          color: MyColors().primary,
          child: const Center(
            child: Text("Training",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700)),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          width: width * 0.85,
          height: height * 0.37,
          decoration: BoxDecoration(
              color: MyColors().third,
              border: Border.all(color: MyColors().primary)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Data training : ${trainingValues[6]}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500)),
                    Column(children: [
                      CustomList(
                        bentuk_wajah: "Diamond",
                        jumlah_data: "${trainingValues[0]}",
                      ),
                      CustomList(
                        bentuk_wajah: "Oval",
                        jumlah_data: "${trainingValues[2]}",
                      ),
                      CustomList(
                        bentuk_wajah: "Round",
                        jumlah_data: "${trainingValues[3]}",
                      ),
                      CustomList(
                        bentuk_wajah: "Square",
                        jumlah_data: "${trainingValues[4]}",
                      ),
                      CustomList(
                        bentuk_wajah: "Oblong",
                        jumlah_data: "${trainingValues[1]}",
                      ),
                      CustomList(
                        bentuk_wajah: "Triangle",
                        jumlah_data: "${trainingValues[5]}",
                      ),
                    ]),
                  ])),
        ),
        Container(
          width: width * 0.85,
          height: 20,
          color: MyColors().primary,
        ),
      ],
    );
  }

  Container titlePageVerification() {
    return Container(
      alignment: Alignment.topLeft,
      width: 250,
      height: 50,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 19, 21, 34),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      child: const Center(
        child: Text(
          "Verification",
          style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  CustomBackButton backButtonPreprocess(BuildContext context) {
    return CustomBackButton(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.size,
              alignment: Alignment.center,
              duration: const Duration(seconds: 1),
              child: const TrainPreprocessingPage()),
          // ),
        );
      },
    );
  }
}
