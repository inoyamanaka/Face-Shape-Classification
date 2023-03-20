import 'package:face_shape/Scenes/Tampilan_model_result.dart';
import 'package:face_shape/Scenes/Tampilan_upload_dataset.dart';
import 'package:face_shape/widgets/custom_backbtn.dart';
import 'package:face_shape/widgets/custom_header_2.dart';
import 'package:face_shape/widgets/custom_media2.dart';
import 'package:face_shape/widgets/cutom_deskripsi_preprocess.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class PreprocessingScreen extends StatefulWidget {
  const PreprocessingScreen({super.key});

  @override
  State<PreprocessingScreen> createState() => _PreprocessingScreenState();
}

class _PreprocessingScreenState extends State<PreprocessingScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width; // lebar layar
    final double height = size.height; // tinggi l

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UploadDataScreen()),
          );
          return false;
        },
        child: Container(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.89,
                  width: width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBackButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.size,
                                  alignment: Alignment.center,
                                  duration: Duration(seconds: 1),
                                  child: UploadDataScreen()),
                              // ),
                            );
                          },
                        ),
                        SizedBox(height: 15),
                        Container(
                          alignment: Alignment.topLeft,
                          width: 250,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 19, 21, 34),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Center(
                            child: Text(
                              "Image Preprocessing",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(height: 10),
                                Container(
                                  child: Column(
                                    children: [
                                      CustomHeader2(isi: "Face Cropping"),
                                      SizedBox(height: 15),
                                      FaceCroppingCard(
                                          deskripsi:
                                              "Face cropping merupakan proses melakukan cropp pada area yang ada di sekitar wajah saja sehingga bagian lain akan dilakukan crop atau dihilangkan",
                                          gambar:
                                              "Assets/Images/face_cropping.png",
                                          tahap: "face_cropping"),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  child: Column(
                                    children: [
                                      CustomHeader2(isi: "Facial Landmark"),
                                      SizedBox(height: 10),
                                      FaceCroppingCard(
                                          deskripsi:
                                              "Facial landmark merupakan proses pemberian landmark pada area-area yang merepresentasikan bagian-bagian wajah",
                                          gambar:
                                              "Assets/Images/facial_landmark.png",
                                          tahap: "facial_landmark"),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  child: Column(
                                    children: [
                                      CustomHeader2(isi: "Landmark Extraction"),
                                      SizedBox(height: 10),
                                      FaceCroppingCard(
                                        deskripsi:
                                            "Landmark extraction merupakan proses ekstraksi landmark pada wajah sehingga hanya gambar nantinya hanya berupa landmarknya saja",
                                        gambar:
                                            "Assets/Images/landmark_extraction.png",
                                        tahap: "landmark_extraction",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          width: 250,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 19, 21, 34),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Center(
                            child: Text(
                              "Model Parameter",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                CustomButton2(
                  isi: "Berikutnya",
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: ModelResultScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
              ]),
        ),
      ),
    );
  }
}
