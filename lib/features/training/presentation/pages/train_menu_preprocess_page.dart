// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:face_shape/config/config.dart';
import 'package:face_shape/core/di/injection.dart';
import 'package:face_shape/core/router/routes.dart';
import 'package:face_shape/features/training/data/models/request/param_body.dart';
import 'package:face_shape/features/training/presentation/bloc/training_bloc.dart';
import 'package:face_shape/features/training/presentation/widgets/card_image_preprocess.dart';
import 'package:face_shape/features/training/presentation/widgets/title_train.dart';
import 'package:face_shape/features/training/presentation/widgets/top_decoration_train.dart';
import 'package:face_shape/features/training/presentation/widgets/train_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TrainPreprocessingPage extends StatefulWidget {
  const TrainPreprocessingPage({super.key});

  @override
  State<TrainPreprocessingPage> createState() => _TrainPreprocessingPageState();
}

class _TrainPreprocessingPageState extends State<TrainPreprocessingPage> {
  final _formKey = GlobalKey<FormState>();

  String _selectedOption = "adam";
  final setParamBloc = sl<TrainBloc>();

  final optimizer = TextEditingController();
  final epoch = TextEditingController();
  final batchSize = TextEditingController();

  final List<String> _options = [
    'adam',
    'RMSprop',
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final MyColors myColor = MyColors();
    final MyFonts myFonts = MyFonts();

    double tli = 400;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () async {
          Get.toNamed(Routes.trainMenu);
          return false;
        },
        child: BlocProvider(
          create: (context) => setParamBloc,
          child: ScreenUtilInit(
            builder: (context, child) =>
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: size.height,
                width: size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopMenuTrain(ontap: () {
                        Get.toNamed(Routes.trainMenu);
                      }),
                      SizedBox(height: 15.h),
                      const TitlePage(text: 'Image Preprocessing')
                          .animate()
                          .slideY(begin: 1, end: 0),
                      imageExample().animate().slideY(begin: 1, end: 0),
                      SizedBox(height: 20.h),
                      const TitlePage(text: 'Model Parameter')
                          .animate()
                          .slideY(begin: 1, end: 0),
                      SizedBox(height: 10.h),
                      paramsInputForm(myFonts, myColor, tli)
                          .animate()
                          .slideY(begin: 1, end: 0),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView paramsInputForm(
      MyFonts myFonts, MyColors myColor, double tli) {
    return SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Batch Size", style: myFonts.primary),
                  SizedBox(height: 10.h),
                  batchSizeInput(),
                  SizedBox(height: 10.h),
                  Text("Jumlah Epoch", style: myFonts.primary),
                  SizedBox(height: 10.h),
                  epochInput(tli),
                  SizedBox(height: 10.h),
                  Text("Optimizer", style: myFonts.primary),
                  SizedBox(height: 10.h),
                  optimizerInput(myColor),
                  SizedBox(height: 20.h),
                  TrainNextButton(
                    text: "Verification",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        setParamBloc.add(SetParamEvent(
                            body: ParamBody(
                                batchSize: int.parse(batchSize.text),
                                epoch: int.parse(epoch.text),
                                optimizer: _selectedOption)));

                        Get.toNamed(Routes.trainVerif);
                      }
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ));
  }

  TextFormField batchSizeInput() {
    return TextFormField(
      controller: batchSize,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nama harus diisi';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "Minimal 16",
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.clear),
          ),
          border: const OutlineInputBorder()),
    );
  }

  TextFormField epochInput(double tli) {
    return TextFormField(
      controller: epoch,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nama harus diisi';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "3",
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                tli = 1000;
              });
            },
            icon: const Icon(Icons.clear),
          ),
          border: const OutlineInputBorder()),
    );
  }

  Center optimizerInput(MyColors myColor) {
    return Center(
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        hint: const Text('Select an option'),
        value: _selectedOption,
        isExpanded: true,
        isDense: true,
        focusColor: myColor.primary,
        onChanged: (newValue) {
          setState(() {
            _selectedOption = newValue!;
            // sendDropdownValue(_selectedOption);
          });
        },
        items: _options.map((option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList(),
      ),
    );
  }

  SingleChildScrollView imageExample() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            SizedBox(height: 10.h),
            const CardImage(
              title: 'Face Cropping',
              deskripsi:
                  'Facial landmark merupakan proses pemberian landmark pada area-area yang merepresentasikan bagian-bagian wajah',
              image: 'Assets/Images/facial_landmark.png',
              tahap: 'facial_landmark',
            ),
            SizedBox(width: 10.w),
            const CardImage(
              title: 'Facial Landmark',
              deskripsi:
                  'Facial landmark merupakan proses pemberian landmark pada area-area yang merepresentasikan bagian-bagian wajah',
              image: 'Assets/Images/facial_landmark.png',
              tahap: 'facial_landmark',
            ),
            SizedBox(width: 10.w),
            const CardImage(
              title: 'Landmark Extraction',
              deskripsi:
                  'Landmark extraction merupakan proses ekstraksi landmark pada wajah sehingga hanya gambar nantinya hanya berupa landmarknya saja',
              image: 'Assets/Images/landmark_extraction.png',
              tahap: 'landmark_extraction',
            ),
          ],
        ),
      ),
    );
  }
}
