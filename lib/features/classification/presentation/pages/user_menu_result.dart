import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:face_shape/config/config.dart';
import 'package:face_shape/config/config_url.dart';
import 'package:face_shape/core/di/injection.dart';
import 'package:face_shape/core/models/ciri_wajah.dart';
import 'package:face_shape/core/router/routes.dart';
import 'package:face_shape/features/classification/presentation/bloc/classification_bloc.dart';
import 'package:face_shape/features/classification/presentation/widgets/custom_button.dart';
import 'package:face_shape/features/classification/presentation/widgets/title_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/user_result_card.dart';
import 'package:face_shape/features/classification/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:shimmer/shimmer.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
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
            Get.toNamed(Routes.userMenu);
            return false;
          },
          child: BlocBuilder<ClassificationBlocGet, GetClassificationState>(
            builder: (context, state) {
              if (state is GetClassificationLoading ||
                  state is GetClassificationInitial) {
                return const LoadingOverlay(
                  isLoading: true,
                  text: "Menampilkan Hasil.......",
                );
              }
              if (state is GetClassificationSuccess) {
                return ScreenUtilInit(
                  builder: (context, child) => Stack(children: [
                    Column(
                      children: [
                        SizedBox(
                          height: height,
                          child: SingleChildScrollView(
                            child: Column(children: [
                              topDecoration(),
                              SizedBox(height: 15.h),
                              const TitleApp(textTitle: "Hasil Deteksi Wajah"),
                              SizedBox(height: 5.h),
                              imageResult(state.dataImageEntity.urls!)
                                  .animate()
                                  .slideY(begin: 1, end: 0),
                              sliderIndicator(state.dataImageEntity.urls!),
                              SizedBox(height: 15.h),
                              imageResult2(
                                      height,
                                      state.dataImageEntity.bentukWajah!,
                                      state.dataImageEntity.persentase!)
                                  .animate()
                                  .slideY(
                                      begin: 1,
                                      end: 0,
                                      delay: const Duration(milliseconds: 500)),
                              SizedBox(height: 15.h),
                              imageResult3(ciriWajah,
                                      state.dataImageEntity.bentukWajah!)
                                  .animate()
                                  .slideY(begin: 1, end: 0),
                              SizedBox(height: 90.h)
                            ]),
                          ),
                        ),
                      ],
                    ),
                    backButtonUser(context),
                  ]),
                );
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
      left: 20.w,
      right: 20.w,
      bottom: 10.h,
      child: CustomButton(
        onTap: () async {
          await Dio().get(ApiUrl.Url_delete_img);
          Get.toNamed(Routes.menu);
        },
        text: "main menu",
        imageAsset: "Assets/Icons/main-menu.png",
        width: 50.w,
        height: 40.h,
      ),
    );
  }

  Container imageResult3(CiriWajah ciriWajah, String bentukWajah) {
    return Container(
      height: 300.h,
      width: 300.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors().third,
        border: Border.all(
          color: Colors.black,
          width: 2.w,
        ),
      ),
      child: Column(children: [
        SizedBox(height: 15.h),
        Text(
          "Ciri dari wajah",
          style: TextStyle(
              fontSize: 18.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 250.h,
          width: 280.w,
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
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.black,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                      text: deskripsiWajah[index],
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
                )
              : Container(),
        )
      ]),
    );
  }

  Container imageResult2(double height, String bentukWajah, double persentase) {
    return Container(
      height: 200.h,
      width: 300.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors().third,
        border: Border.all(
          color: Colors.black,
          width: 2.w,
        ),
      ),
      child: ResultCard(bentuk_wajah: bentukWajah, persentase: persentase),
    );
  }

  SizedBox imageResult(List<String> imageUrls) {
    return SizedBox(
      // atur lebar, tinggi, dan warna latar belakang container sesuai kebutuhan
      width: 280.w,
      height: 300.h,
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
          width: _currentIndex == index ? 25.w : 10.w,
          height: 10.h,
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
      bottom: 0.h,
      left: 12.w,
      right: 12.w,
      top: 0.h,
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Text(imageDes[_currentIndex],
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700)))),
    );
  }

  Positioned imagePreprocessBox(List<String> imageUrls) {
    return Positioned(
      bottom: 65.h,
      left: 5.w,
      right: 5.w,
      top: 50.h,
      child: Container(
        height: 230.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: CarouselSlider(
          items: imageUrls.map((image) {
            return Container(
              width: 220.w,
              height: 100.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
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
            height: 230.h,
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

  Container topDecoration() {
    return Container(
      alignment: Alignment.topRight,
      child: SvgPicture.asset(
        "Assets/Svgs/hiasan_atas.svg",
      ),
    );
  }
}
