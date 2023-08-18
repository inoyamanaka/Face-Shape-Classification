// import 'package:face_shape/config/config.dart';
// import 'package:face_shape/features/classification/domain/usecases/upload_image.dart';
// import 'package:face_shape/features/classification/presentation/pages/main_menu_page.dart';
// import 'package:face_shape/features/classification/presentation/widgets/no_face_detection_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:page_transition/page_transition.dart';

// class UserMenuWidget extends StatelessWidget {
//   const UserMenuWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }

//   Future<void> UploadImageWidget(BuildContext context) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     String path = pickedFile!.path;
//     bool _isLoading = true;

//     final uploadImage = UploadImage();
//     bool isSuccess = await uploadImage.call(path);

//     isSuccess == true
//         ? Navigator.push(
//             context,
//             PageTransition(
//               type: PageTransitionType.leftToRightWithFade,
//               child: MenuMode(),
//             ))
//         : NoFaceDetection(context);
//   }
// }
