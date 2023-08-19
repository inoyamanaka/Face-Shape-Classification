import 'package:carousel_slider/carousel_slider.dart';
import 'package:face_shape/Datas/url_host.dart';
import 'package:face_shape/core/di/injection.dart';
import 'package:face_shape/core/models/ciri_wajah.dart';
import 'package:face_shape/core/router/routes.dart';
import 'package:face_shape/features/classification/presentation/bloc/classification_bloc.dart';
import 'package:face_shape/features/classification/presentation/widgets/custom_button.dart';
import 'package:face_shape/features/classification/presentation/widgets/title_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/user_result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  void deleteImgs() async {
    await http.get(Uri.parse(ApiUrl.Url_delete_img));
  }

  PageController pageController = PageController(viewportFraction: 0.7);

  final getBloc = sl<ClassificationBlocGet>();

  final List<String> imageDes = [
    "Original Image",
    "Face Cropping",
    "Facial Landmark",
    "Landmark Extraction"
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getBloc.add(GetEvent());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;

    final ciriWajah = CiriWajah();
    return BlocProvider(
      create: (context) => getBloc,
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            Get.toNamed(Routes.userCamera);
            return false;
          },
          child: BlocBuilder<ClassificationBlocGet, GetClassificationState>(
            builder: (context, state) {
              if (state is GetClassificationLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is GetClassificationSuccess) {
                return Stack(children: [
                  Column(
                    children: [
                      SizedBox(
                        height: height,
                        child: SingleChildScrollView(
                          child: Column(children: [
                            TopDecoration(),
                            const SizedBox(height: 15),
                            const TitleApp(textTitle: "Hasil Deteksi Wajah"),
                            const SizedBox(height: 5),
                            imageResult(state.dataImageEntity.urls!),
                            sliderIndicator(state.dataImageEntity.urls!),
                            const SizedBox(height: 15),
                            imageResult2(
                                height,
                                state.dataImageEntity.bentukWajah!,
                                state.dataImageEntity.persentase!),
                            const SizedBox(height: 15),
                            imageResult3(
                                ciriWajah, state.dataImageEntity.bentukWajah!),
                            const SizedBox(height: 90)
                          ]),
                        ),
                      ),
                    ],
                  ),
                  backButtonUser(context),
                ]);
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Positioned backButtonUser(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 10,
      child: CustomButton(
        onTap: () {
          deleteImgs();
          Get.toNamed(Routes.menu);
        },
        text: "main menu",
        imageAsset: "Assets/Icons/main-menu.png",
        width: 50,
        height: 40,
      ),
    );
  }

  Container imageResult3(CiriWajah ciriWajah, String bentukWajah) {
    return Container(
      height: 355,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 217, 217, 217),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Column(children: [
        const SizedBox(height: 15),
        const Text(
          "Ciri dari wajah",
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 250,
          width: 280,
          child: ciriWajah.faceShapes.containsKey(bentukWajah)
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    final bentukWajah =
                        ciriWajah.faceShapes.keys.elementAt(index);
                    final deskripsiWajah = ciriWajah.faceShapes[bentukWajah]!;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: RichText(
                              text: TextSpan(
                                text: "• ",
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                      text: deskripsiWajah[index],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
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
                )
              : Container(),
        )
      ]),
    );
  }

  Container imageResult2(double height, String bentukWajah, double persentase) {
    return Container(
      height: height * 0.3,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 217, 217, 217),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: ResultCard(bentuk_wajah: bentukWajah, persentase: persentase),
    );
  }

  SizedBox imageResult(List<String> imageUrls) {
    return SizedBox(
      // atur lebar, tinggi, dan warna latar belakang container sesuai kebutuhan
      width: 300,
      height: 330,
      child: Stack(children: [
        Center(
          child: SvgPicture.asset(
            "Assets/Svgs/report_design.svg",
          ),
        ),
        imagePreprocessBox(imageUrls),
        imagePreprocessDetail()
      ]),
    );
  }

  Row sliderIndicator(List<String> imageUrls) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imageUrls.asMap().entries.map((entry) {
        int index = entry.key;
        // String image = entry.value;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: _currentIndex == index ? 25 : 10,
          height: 10,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: _currentIndex == index ? Colors.black : Colors.grey,
          ),
        );
      }).toList(),
    );
  }

  Positioned imagePreprocessDetail() {
    return Positioned(
      bottom: 0,
      left: 12,
      right: 12,
      top: 0,
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(imageDes[_currentIndex],
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700)))),
    );
  }

  Positioned imagePreprocessBox(List<String> imageUrls) {
    return Positioned(
      bottom: 70,
      left: 12,
      right: 12,
      top: 55,
      child: Container(
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: CarouselSlider(
          items: imageUrls.map((image) {
            return Container(
              width: 220,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    // Jika gambar gagal dimuat karena kesalahan, tampilkan efek shimmer sebagai gantinya
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      period: const Duration(milliseconds: 800),
                      child: Container(
                        color: Colors.grey[300],
                      ),
                    );
                  },
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 230,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  Container TopDecoration() {
    return Container(
      alignment: Alignment.topRight,
      child: SvgPicture.asset(
        "Assets/Svgs/hiasan_atas.svg",
      ),
    );
  }
}
