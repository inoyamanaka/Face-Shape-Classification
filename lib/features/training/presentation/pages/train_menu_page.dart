import 'package:dotted_border/dotted_border.dart';
import 'package:face_shape/config/config.dart';
import 'package:face_shape/core/di/injection.dart';
import 'package:face_shape/core/router/routes.dart';
import 'package:face_shape/features/training/data/models/request/train_request.dart';
import 'package:face_shape/features/training/presentation/bloc/training_bloc.dart';
import 'package:face_shape/features/training/presentation/widgets/dialogue.dart';
import 'package:face_shape/features/training/presentation/widgets/loading_train.dart';
import 'package:face_shape/features/training/presentation/widgets/subtitle_train.dart';
import 'package:face_shape/features/training/presentation/widgets/title_train.dart';
import 'package:face_shape/features/training/presentation/widgets/top_decoration_train.dart';
import 'package:face_shape/features/training/presentation/widgets/train_custom_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TrainMenuPage extends StatefulWidget {
  const TrainMenuPage({super.key});

  @override
  State<TrainMenuPage> createState() => _TrainMenuPage();
}

class _TrainMenuPage extends State<TrainMenuPage>
    with SingleTickerProviderStateMixin {
  late AnimationController loadingController;
  late ValueNotifier<double> loadingControllerP;
  late PlatformFile platformFile;

  final uploadBloc = sl<TrainBloc>();
  // ValueNotifier<double> loadingControllerP = ValueNotifier<double>(0.0);

  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> panduan = [
      "Dataset harus ada dalam format zip",
      "Dataset terdiri dari 6 buah class (diamond, oblong, oval, round, triangle daan square)",
      "Dataset sudah terbagi ke dalam folder training dan testing",
      "Jumlah perbandingan data training dan testing adalah 80:20 dari total dataset yang ada"
    ];
    final Size size = MediaQuery.of(context).size;
    final double width = size.width; // lebar layar
    final double height = size.height; // tinggi layar

    // loadingController = ValueNotifier(progressPercent);

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Get.toNamed(Routes.menu);
          return false;
        },
        // width: width,
        child: ScreenUtilInit(
          builder: (context, child) => BlocProvider<TrainBloc>(
            create: (context) => uploadBloc,
            child:
                BlocConsumer<TrainBloc, TrainState>(listener: (context, state) {
              if (state is UploadDatasetStateSuccess) {
                successDialogue(context);
              }
            }, builder: (context, state) {
              if (state is UploadDatasetStateInitial) {
                // uploading();
              }
              if (state is UploadDatasetStateLoading) {
                return const LoadingOverlayTrain(
                  text: "Mohon Tunggu Upload...",
                );
              }

              return Stack(children: [
                Column(
                  children: [
                    SizedBox(
                      height: height,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TopMenuTrain(ontap: () {
                                Get.toNamed(Routes.menu);
                              }),
                              SizedBox(height: 15.h),
                              const TitlePage(
                                text: 'Upload Dataset',
                              ).animate().slideY(begin: 1, end: 0),
                              SizedBox(height: 10.h),
                              const SubTitle(text: "Ketentuan Dataset")
                                  .animate()
                                  .slideY(begin: 1, end: 0),
                              SizedBox(height: 5.h),
                              content1(width, panduan)
                                  .animate()
                                  .slideY(begin: 1, end: 0),
                              SizedBox(height: 10.h),
                              const SubTitle(
                                text: 'Contoh Folder',
                              ).animate().slideY(begin: 1, end: 0),
                              SizedBox(height: 5.h),
                              content2(width)
                                  .animate()
                                  .slideY(begin: 1, end: 0),
                              SizedBox(height: 10.h),
                              const SubTitle(
                                text: 'Upload Dataset',
                              ).animate().slideY(begin: 1, end: 0),
                              uploadDataButton()
                                  .animate()
                                  .slideY(begin: 1, end: 0),

                              // uploading(uploadDataSource),
                              SizedBox(height: 100.h)
                            ]),
                      ),
                    ),
                  ],
                ),
                TrainNextButton(
                  text: "Set Parameters",
                  onTap: () {
                    Get.toNamed(Routes.trainPreprocess);
                  },
                ),
              ]);
            }),
          ),
        ),
      ),
    );
  }

  Center content2(double width) {
    return Center(
      child: Container(
        width: width * 0.9,
        height: 220,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 217, 217, 217),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            "Assets/Images/folder_panduan.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Center content1(double width, List<String> panduan) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 217, 217, 217),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            width: 2.w,
          ),
        ),
        child: SizedBox(
            height: 220.h,
            width: 320.w,
            child: ListView.builder(
              itemCount: panduan.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 5.h),
                        child: RichText(
                          text: TextSpan(
                            text: "• ",
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                  text: panduan[index],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }

  InkWell uploadDataButton() {
    return InkWell(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();
          String? path = result!.files.first.path;
          // isSucces = await uploadDataset.call(path!, loadingControllerP);
          uploadBloc.add(UploadDatasetEvent(
              filepath: UploadDatasetFilepathReq(filepath: path!)));
        },
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              dashPattern: const [10, 4],
              strokeCap: StrokeCap.round,
              color: MyColors().primary,
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.blue.shade50.withOpacity(.3),
                    borderRadius: BorderRadius.circular(10)),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.folder_open,
                      color: Color.fromARGB(255, 19, 21, 34),
                      size: 40,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Select your file',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ),
            )));
  }

  void uploadFile(String name, int i) {}
}

// class Test extends StatefulWidget {
//   const Test({
//     super.key,
//     required PlatformFile? platformFile,
//     required this.uploadDataSource,
//   }) : _platformFile = platformFile;

//   final PlatformFile? _platformFile;
//   final UploadDatasetDataSourceImpl uploadDataSource;

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   @override
//   Widget build(BuildContext context) {
//     final progressNotifier = Provider.of<ProgressNotifier>(context);
//     setState(() {
//       print('ini');
//       print(progressNotifier.value);
//     });

//     return Container(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Selected File',
//               style: TextStyle(
//                 color: Colors.grey.shade400,
//                 fontSize: 15.sp,
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.shade200,
//                         offset: const Offset(0, 1),
//                         blurRadius: 3,
//                         spreadRadius: 2,
//                       )
//                     ]),
//                 child: Row(
//                   children: [
//                     ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.asset(
//                           "Assets/Images/zip-file.png",
//                           width: 35.w,
//                           height: 35.h,
//                         )),
//                     SizedBox(
//                       width: 10.h,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             widget._platformFile!.name,
//                             style:
//                                 TextStyle(fontSize: 13.sp, color: Colors.black),
//                           ),
//                           SizedBox(height: 5.h),
//                           // Text(
//                           //   '${(_platformFile!.size / 1024).ceil()} KB',
//                           //   style: TextStyle(
//                           //       fontSize: 13.sp,
//                           //       color: Colors.grey.shade500),
//                           // ),
//                           SizedBox(height: 5.h),
//                           Container(
//                               height: 5.h,
//                               clipBehavior: Clip.hardEdge,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: Colors.blue.shade50,
//                               ),
//                               child: LinearProgressIndicator(
//                                   // value: value,
//                                   )),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//           ],
//         ));
//   }
// }
