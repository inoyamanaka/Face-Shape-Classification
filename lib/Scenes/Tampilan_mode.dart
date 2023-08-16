// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:face_shape/Scenes/Tampilan_menu.dart';
// import 'package:face_shape/Scenes/Tampilan_select_model.dart';
// import 'package:face_shape/Scenes/Tampilan_upload_dataset.dart';
// import 'package:face_shape/features/data/models/main_menu_att.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:page_transition/page_transition.dart';

// import '../features/presentation/widgets/main_menu_widget.dart';

// class MenuMode extends StatefulWidget {
//   const MenuMode({super.key});

//   @override
//   State<MenuMode> createState() => _MenuModeState();
// }

// class _MenuModeState extends State<MenuMode> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final MainMenuAtt attribute = MainMenuAtt();
//     return Scaffold(
//       body: MainMenuWidget(context),
//     );
//   }

//   WillPopScope MainMenuWidget(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         SystemNavigator.pop();
//         return false;
//       },
//       child: Column(
//         children: [
//           TopDecoration(),
//           SizedBox(height: 15),
//           TitleApp(),
//           SizedBox(height: 10),
//           ContentImage(),
//           SliderIndicator(),
//           SubDescription(),
//           ButtonRow(context)
//         ],
//       ),
//     );
//   }

//   Row ButtonRow(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ButtonMenu(context),
//         SizedBox(width: 10),
//         ButtonSetting(context),
//       ],
//     );
//   }

//   Row SliderIndicator() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: MainMenuAtt.imageList.asMap().entries.map((entry) {
//         int index = entry.key;
//         return AnimatedContainer(
//           duration: Duration(milliseconds: 500),
//           width: _currentIndex == index ? 25 : 10,
//           height: 10,
//           margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             shape: BoxShape.rectangle,
//             color: _currentIndex == index ? Colors.black : Colors.grey,
//           ),
//         );
//       }).toList(),
//     );
//   }

//   InkWell ButtonSetting(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         if (_currentIndex == 0) {
//           // pindah page
//           Navigator.push(
//             context,
//             PageTransition(
//               type: PageTransitionType.leftToRightWithFade,
//               child: SelectModelScreen(),
//             ),
//           );
//         } else if (_currentIndex == 1) {
//           // pindah page
//           Navigator.push(
//             context,
//             PageTransition(
//               type: PageTransitionType.leftToRightWithFade,
//               child: SelectModelScreen(),
//             ),
//           );
//         }
//       },
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 500),
//         height: 75,
//         width: 75,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           color: _currentIndex == 1
//               ? Color.fromARGB(255, 212, 245, 252)
//               : Color.fromARGB(255, 19, 21, 34),
//           border: Border.all(
//             color: Colors.black,
//             width: 2.0,
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Image.asset(
//                 _currentIndex == 0
//                     ? "Assets/Icons/user(1).png"
//                     : "Assets/Icons/user(2).png",
//                 width: 45,
//                 height: 45,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   InkWell ButtonMenu(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         if (_currentIndex == 0) {
//           // pindah page
//           Navigator.push(
//             context,
//             PageTransition(
//               type: PageTransitionType.leftToRightWithFade,
//               child: UploadDataScreen(),
//             ),
//           );
//         } else if (_currentIndex == 1) {
//           // pindah page
//           Navigator.push(
//             context,
//             PageTransition(
//               type: PageTransitionType.leftToRightWithFade,
//               child: MainMenu(),
//             ),
//           );
//         }
//       },
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 500),
//         height: 75,
//         width: 250,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           color: _currentIndex == 1
//               ? Color.fromARGB(255, 212, 245, 252)
//               : Color.fromARGB(255, 19, 21, 34),
//           border: Border.all(
//             color: Colors.black,
//             width: 2.0,
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               MainMenuAtt.mode[_currentIndex],
//               style: TextStyle(
//                 fontSize: 20,
//                 fontFamily: 'Urbanist',
//                 color: _currentIndex == 1
//                     ? Color.fromARGB(255, 19, 21, 34)
//                     : Color.fromARGB(255, 212, 245, 252),
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Container ContentImage() {
//     return Container(
//       width: 300,
//       height: 400,
//       child: CarouselSlider(
//         items: MainMenuAtt.imageList.map((image) {
//           return Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(40.0),
//               border: Border.all(
//                 color: Colors.black, // warna border
//                 width: 2, // ketebalan border
//               ),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(40.0),
//               child: Image.asset(
//                 image,
//                 width: 250,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           );
//         }).toList(),
//         options: CarouselOptions(
//           height: 330,
//           autoPlayInterval: Duration(seconds: 3),
//           autoPlayCurve: Curves.fastOutSlowIn,
//           enlargeCenterPage: true,
//           scrollDirection: Axis.horizontal,
//           onPageChanged: (index, reason) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//         ),
//       ),
//     );
//   }

//   Padding SubDescription() {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Text(MainMenuAtt.deskripsi[_currentIndex],
//           textAlign: TextAlign.center,
//           style: TextStyle(
//               fontSize: 16,
//               color: Colors.black,
//               fontFamily: 'Urbanist',
//               fontWeight: FontWeight.w500)),
//     );
//   }
// }
