import 'package:face_shape/config/config.dart';
import 'package:face_shape/features/classification/presentation/pages/dev_menu_preprocess_page.dart';
import 'package:face_shape/features/classification/presentation/pages/main_menu_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/dev_menu_widget.dart';
import 'package:face_shape/features/classification/presentation/widgets/dev_nextBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:file_picker/file_picker.dart';

class DevMenuPage extends StatefulWidget {
  const DevMenuPage({super.key});

  @override
  State<DevMenuPage> createState() => _DevMenuPage();
}

class _DevMenuPage extends State<DevMenuPage>
    with SingleTickerProviderStateMixin {
  PlatformFile? _platformFile;
  late AnimationController loadingController;
  late ValueNotifier<double> loadingControllerP;
  List<_FileData> _fileList = [];

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
    final MyColors myColors = MyColors();

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MenuMode()),
          );
          return false;
        },
        child: Container(
          // width: width,
          child: Stack(children: [
            Column(
              children: [
                Container(
                  height: height,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TopMenu(context),
                          SizedBox(height: 15),
                          TitlePage().animate().slideY(begin: 1, end: 0),
                          SizedBox(height: 10),
                          SubTitle1(myColors)
                              .animate()
                              .slideY(begin: 1, end: 0),
                          SizedBox(height: 5),
                          Content1(width, panduan)
                              .animate()
                              .slideY(begin: 1, end: 0),
                          SizedBox(height: 10),
                          SubTitle2(myColors)
                              .animate()
                              .slideY(begin: 1, end: 0),
                          SizedBox(height: 5),
                          Content2(width).animate().slideY(begin: 1, end: 0),
                          SizedBox(height: 10),
                          SubTitle3(myColors)
                              .animate()
                              .slideY(begin: 1, end: 0),
                          DevMenuWidget()
                              .ButtonUploadDataset(context)
                              .animate()
                              .slideY(begin: 1, end: 0),
                          _platformFile != null ? Uploading() : Container(),
                          SizedBox(height: 100)
                        ]),
                  ),
                ),
              ],
            ),
            DevNextButton(
              isi: "Berikutnya T",
              page: PreprocessingScreen(),
            ),
          ]),
        ),
      ),
    );
  }

  Center TopMenu(BuildContext context) {
    return Center(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: MenuMode()),
                  );
                },
                child: Image.asset(
                  "Assets/Icons/back.png",
                  width: 35,
                  height: 35,
                ),
              ),
            ),
            SvgPicture.asset(
              "Assets/Svgs/hiasan_atas.svg",
            ),
          ],
        ),
      ),
    );
  }

  Padding SubTitle3(MyColors myColors) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Text(
        "Upload Dataset",
        style: TextStyle(
            color: myColors.primary,
            fontSize: 16,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w700),
      ),
    );
  }

  Center Content2(double width) {
    return Center(
      child: Container(
        width: width * 0.9,
        height: 220,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 217, 217, 217),
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

  Padding SubTitle2(MyColors myColors) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Text(
        "Contoh Folder",
        style: TextStyle(
            color: myColors.primary,
            fontSize: 16,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w700),
      ),
    );
  }

  Center Content1(double width, List<String> panduan) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 217, 217, 217),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: SizedBox(
            height: 250,
            width: width * 0.9,
            child: ListView.builder(
              itemCount: panduan.length,
              itemBuilder: (BuildContext context, int index) {
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
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                  text: panduan[index],
                                  style: TextStyle(
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
            )),
      ),
    );
  }

  Padding SubTitle1(MyColors myColors) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Text(
        "Ketentuan Dataset",
        style: TextStyle(
            color: myColors.primary,
            fontSize: 16,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w700),
      ),
    );
  }

  Container TitlePage() {
    return Container(
      width: 250,
      height: 50,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 19, 21, 34),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      child: Center(
        child: Text(
          "Upload Dataset",
          style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  ValueListenableBuilder Uploading() {
    return ValueListenableBuilder<double>(
      valueListenable: loadingControllerP,
      builder: (context, value, child) {
        return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected File',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(0, 1),
                            blurRadius: 3,
                            spreadRadius: 2,
                          )
                        ]),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "Assets/Images/zip-file.png",
                              width: 35,
                              height: 35,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _platformFile!.name,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${(_platformFile!.size / 1024).ceil()} KB',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey.shade500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  height: 5,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue.shade50,
                                  ),
                                  child: LinearProgressIndicator(
                                    value: loadingControllerP.value,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ));
      },
    );
  }

  void uploadFile(String name, int i) {}
}

class _FileData {
  late PlatformFile platformFile;
  late double progressPercent;
  late ValueNotifier<double> loadingController;

  _FileData({
    required this.platformFile,
    required this.progressPercent,
  }) {
    loadingController = ValueNotifier(progressPercent);
  }
}
