// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:face_shape/Datas/color.dart';
// import 'package:face_shape/Datas/url_host.dart';
// import 'package:face_shape/Scenes/Tampilan_mode.dart';
// import 'package:face_shape/Scenes/Tampilan_preprocessing.dart';
// import 'package:face_shape/widgets/custom_media2.dart';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:page_transition/page_transition.dart';
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:iconsax/iconsax.dart';

// class UploadDataScreen extends StatefulWidget {
//   const UploadDataScreen({super.key});

//   @override
//   State<UploadDataScreen> createState() => _UploadDataScreenState();
// }

// class _UploadDataScreenState extends State<UploadDataScreen>
//     with SingleTickerProviderStateMixin {
//   FilePickerResult? _file;
//   File? _file2;
//   PlatformFile? _platformFile;
//   late AnimationController loadingController;
//   List<_FileData> _fileList = [];

//   Future<void> _uploadFile(String filename, int index) async {
//     // Mengambil path file yang dipilih
//     String path = _file!.files.first.path!;
//     try {
//       Dio dio = new Dio();
//       FormData formData = new FormData.fromMap({
//         'file': await MultipartFile.fromFile(path, filename: filename),
//       });
//       setState(() {
//         loadingController.value = 0.0;
//       });
//       Response response = await dio.post(ApiUrl.Url_model, data: formData,
//           onSendProgress: (int sentBytes, int totalBytes) {
//         double progressPercent = (sentBytes / totalBytes) * 100 / 100;

//         setState(() {
//           loadingController.value = progressPercent;
//           print(progressPercent);
//           if (loadingController.value == 1.0) {}
//         });
//       });

//       if (response.statusCode == 200) {
//         AwesomeDialog(
//           context: context,
//           title: 'Upload selesai',
//           desc: 'File anda telah berhasil diunggah',
//           dialogType: DialogType.success,
//           btnOkOnPress: () {
//             Navigator.push(
//               context,
//               PageTransition(
//                 type: PageTransitionType.rightToLeftWithFade,
//                 child: PreprocessingScreen(),
//               ),
//             );
//           },
//         )..show();
//       }

//       // Mengatur nilai progress menjadi 1 pada item yang telah selesai diunggah
//       setState(() {
//         loadingController.value = 1.0;
//       });

//       print("response : ${response.statusCode}");
//     } catch (e) {
//       print('Error uploading file: $e');
//     }
//   }

//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       setState(() {
//         _file = result;
//         _file2 = File(result.files.single.path!);
//         _platformFile = result.files.first;
//         _uploadFile(_file!.files.first.name, 0);
//       });
//     }
//     // loadingController.forward();
//   }

//   @override
//   void initState() {
//     loadingController = AnimationController(
//       vsync: this,
//     )..addListener(() {
//         setState(() {});
//       });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<String> panduan = [
//       "Dataset harus ada dalam format zip",
//       "Dataset terdiri dari 6 buah class (diamond, oblong, oval, round, triangle daan square)",
//       "Dataset sudah terbagi ke dalam folder training dan testing",
//       "Jumlah perbandingan data training dan testing adalah 80:20 dari total dataset yang ada"
//     ];
//     final Size size = MediaQuery.of(context).size;
//     final double width = size.width; // lebar layar
//     final double height = size.height; // tinggi layar

//     return Scaffold(
//       body: WillPopScope(
//         onWillPop: () async {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => MenuMode()),
//           );
//           return false;
//         },
//         child: Container(
//           // width: width,
//           child: Stack(children: [
//             Column(
//               children: [
//                 Container(
//                   height: height,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     physics: AlwaysScrollableScrollPhysics(),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Center(
//                             child: Container(
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(10),
//                                     child: InkWell(
//                                       onTap: () {
//                                         Navigator.push(
//                                           context,
//                                           PageTransition(
//                                               type: PageTransitionType
//                                                   .rightToLeftWithFade,
//                                               child: MenuMode()),
//                                         );
//                                       },
//                                       child: Image.asset(
//                                         "Assets/Icons/back.png",
//                                         width: 35,
//                                         height: 35,
//                                       ),
//                                     ),
//                                   ),
//                                   SvgPicture.asset(
//                                     "Assets/Svgs/hiasan_atas.svg",
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           Container(
//                             width: 250,
//                             height: 50,
//                             decoration: BoxDecoration(
//                                 color: Color.fromARGB(255, 19, 21, 34),
//                                 borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(20),
//                                     bottomRight: Radius.circular(20))),
//                             child: Center(
//                               child: Text(
//                                 "Upload Dataset",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 22,
//                                     fontFamily: 'Urbanist',
//                                     fontWeight: FontWeight.w700),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 20.0, vertical: 10),
//                             child: Text(
//                               "Ketentuan Dataset",
//                               style: TextStyle(
//                                   color: PrimColor.primary,
//                                   fontSize: 16,
//                                   fontFamily: 'Urbanist',
//                                   fontWeight: FontWeight.w700),
//                             ),
//                           ),
//                           Center(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Color.fromARGB(255, 217, 217, 217),
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                   color: Colors.black,
//                                   width: 2,
//                                 ),
//                               ),
//                               child: SizedBox(
//                                   height: 250,
//                                   width: width * 0.9,
//                                   child: ListView.builder(
//                                     itemCount: panduan.length,
//                                     itemBuilder:
//                                         (BuildContext context, int index) {
//                                       return Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Expanded(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5),
//                                               child: RichText(
//                                                 text: TextSpan(
//                                                   text: "• ",
//                                                   style: TextStyle(
//                                                       fontSize: 20,
//                                                       color: Colors.black,
//                                                       fontFamily: 'Urbanist',
//                                                       fontWeight:
//                                                           FontWeight.w500),
//                                                   children: [
//                                                     TextSpan(
//                                                         text: panduan[index],
//                                                         style: TextStyle(
//                                                             color: Colors.black,
//                                                             fontSize: 16,
//                                                             fontFamily:
//                                                                 'Urbanist',
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w500)),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   )),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 20.0, vertical: 10),
//                             child: Text(
//                               "Contoh Folder",
//                               style: TextStyle(
//                                   color: PrimColor.primary,
//                                   fontSize: 16,
//                                   fontFamily: 'Urbanist',
//                                   fontWeight: FontWeight.w700),
//                             ),
//                           ),
//                           Center(
//                             child: Container(
//                               width: width * 0.9,
//                               height: 220,
//                               decoration: BoxDecoration(
//                                 color: Color.fromARGB(255, 217, 217, 217),
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                   color: Colors.black,
//                                   width: 2,
//                                 ),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(20),
//                                 child: Image.asset(
//                                   "Assets/Images/folder_panduan.png",
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 20.0, vertical: 10),
//                             child: Text(
//                               "Upload Dataset",
//                               style: TextStyle(
//                                   color: PrimColor.primary,
//                                   fontSize: 16,
//                                   fontFamily: 'Urbanist',
//                                   fontWeight: FontWeight.w700),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               _pickFile();
//                             },
//                             child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 20.0, vertical: 0),
//                                 child: DottedBorder(
//                                   borderType: BorderType.RRect,
//                                   radius: Radius.circular(10),
//                                   dashPattern: [10, 4],
//                                   strokeCap: StrokeCap.round,
//                                   color: Color.fromARGB(255, 19, 21, 34),
//                                   child: Container(
//                                     width: double.infinity,
//                                     height: 100,
//                                     decoration: BoxDecoration(
//                                         color:
//                                             Colors.blue.shade50.withOpacity(.3),
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Iconsax.folder_open,
//                                           color:
//                                               Color.fromARGB(255, 19, 21, 34),
//                                           size: 40,
//                                         ),
//                                         SizedBox(
//                                           height: 15,
//                                         ),
//                                         Text(
//                                           'Select your file',
//                                           style: TextStyle(
//                                               fontSize: 15,
//                                               color: Colors.black),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                           _platformFile != null
//                               ? Container(
//                                   padding: EdgeInsets.all(20),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Selected File',
//                                         style: TextStyle(
//                                           color: Colors.grey.shade400,
//                                           fontSize: 15,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Container(
//                                           padding: EdgeInsets.all(8),
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               color: Colors.white,
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: Colors.grey.shade200,
//                                                   offset: Offset(0, 1),
//                                                   blurRadius: 3,
//                                                   spreadRadius: 2,
//                                                 )
//                                               ]),
//                                           child: Row(
//                                             children: [
//                                               ClipRRect(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   child: Image.asset(
//                                                     "Assets/Images/zip-file.png",
//                                                     width: 35,
//                                                     height: 35,
//                                                   )),
//                                               SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Expanded(
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       _platformFile!.name,
//                                                       style: TextStyle(
//                                                           fontSize: 13,
//                                                           color: Colors.black),
//                                                     ),
//                                                     SizedBox(
//                                                       height: 5,
//                                                     ),
//                                                     Text(
//                                                       '${(_platformFile!.size / 1024).ceil()} KB',
//                                                       style: TextStyle(
//                                                           fontSize: 13,
//                                                           color: Colors
//                                                               .grey.shade500),
//                                                     ),
//                                                     SizedBox(
//                                                       height: 5,
//                                                     ),
//                                                     Container(
//                                                         height: 5,
//                                                         clipBehavior:
//                                                             Clip.hardEdge,
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(5),
//                                                           color: Colors
//                                                               .blue.shade50,
//                                                         ),
//                                                         child:
//                                                             LinearProgressIndicator(
//                                                           value:
//                                                               loadingController
//                                                                   .value,
//                                                         )),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           )),
//                                     ],
//                                   ))
//                               : Container(),
//                           SizedBox(
//                             height: 100,
//                           )
//                         ]),
//                   ),
//                 ),
//               ],
//             ),
//             Positioned(
//               // top: 10,
//               left: 20,
//               right: 20,
//               bottom: 10,
//               child: CustomButton2(
//                 isi: "Berikutnya",
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     PageTransition(
//                       type: PageTransitionType.rightToLeftWithFade,
//                       child: PreprocessingScreen(),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }

// class _FileData {
//   late PlatformFile platformFile;
//   late double progressPercent;
//   late ValueNotifier<double> loadingController;

//   _FileData({
//     required this.platformFile,
//     required this.progressPercent,
//   }) {
//     loadingController = ValueNotifier(progressPercent);
//   }
// }
