import 'package:face_shape/Scenes/Tampilan_select_model.dart';
import 'package:face_shape/Scenes/Tampilan_upload_dataset.dart';
import 'package:face_shape/widgets/costum_hasil_deskripsi.dart';
import 'package:face_shape/widgets/costum_header.dart';
import 'package:face_shape/widgets/custom_backbtn.dart';
import 'package:face_shape/widgets/custom_header_2.dart';
import 'package:face_shape/widgets/custom_image_slide.dart';
import 'package:face_shape/widgets/custom_media2.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class ModelResultScreen extends StatefulWidget {
  const ModelResultScreen({super.key});

  @override
  State<ModelResultScreen> createState() => _ModelResultScreenState();
}

class _ModelResultScreenState extends State<ModelResultScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width; // lebar layar
    final double height = size.height; // tinggi layar
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Container(
              height: height * 0.89,
              child: SingleChildScrollView(
                  child: Column(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeftWithFade,
                              child: UploadDataScreen()),
                        );
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomHeader(isi: "Model Result"),
                    SizedBox(height: 10),
                    CustomHeader2(isi: "Face Cropping"),
                    ImageSlide(),
                    SizedBox(height: 15),
                    CustomHeader2(isi: "Facial Landmark"),
                    ImageSlide(),
                    SizedBox(height: 15),
                    CustomHeader2(isi: "Landmark Extraction"),
                    ImageSlide(),
                    SizedBox(height: 15),
                    CustomHeader2(isi: "Hasil Akurasi"),
                    SizedBox(height: 10),
                    Center(
                        child: HasilAkurasiCard(
                      "Diamong",
                      "Hasil Laporan Training",
                      "Training",
                      98,
                    )),
                    SizedBox(height: 15),
                    Center(
                        child: HasilAkurasiCard(
                      "Oval",
                      "Hasil Laporan Testin",
                      "Testing",
                      90,
                    )),
                    SizedBox(height: 15),
                    CustomHeader2(isi: "Hasil Tambahan"),
                    SizedBox(height: 15),
                    Center(
                      child: Container(
                        height: 200,
                        width: 280,
                        color: Color.fromARGB(255, 217, 217, 217),
                        child: Image.network(
                          "nanti_diisi_url",
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
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
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: Container(
                        height: 200,
                        width: 280,
                        color: Color.fromARGB(255, 217, 217, 217),
                        child: Image.network(
                          "nanti_diisi_url",
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
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
                    ),
                  ],
                ),
              ]))),
          Spacer(),
          CustomButton2(
            isi: "Berikutnya",
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  child: SelectModelScreen(),
                ),
              );
            },
          ),
          SizedBox(
            height: 5,
          ),
        ],
      )),
    );
  }
}
