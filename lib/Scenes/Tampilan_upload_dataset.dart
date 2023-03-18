import 'package:face_shape/Scenes/Tampilan_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class UploadDataScreen extends StatelessWidget {
  const UploadDataScreen({super.key});

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
    return Scaffold(
      body: Container(
        // color: Color.fromRGBO(163, 45, 45, 1),
        child: Column(
          children: [
            Container(
              height: height * 0.89,
              width: width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                                        type: PageTransitionType
                                            .rightToLeftWithFade,
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
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Center(
                          child: Text(
                            "Upload Dataset",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 217, 217, 217),
                              borderRadius: BorderRadius.circular(10)),
                          child: SizedBox(
                              height: 250,
                              width: width * 0.9,
                              child: ListView.builder(
                                itemCount: panduan.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                        fontWeight:
                                                            FontWeight.w500)),
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          width: width * 0.9,
                          height: 220,
                          child: Image.asset(
                            "Assets/Images/folder_panduan.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 75,
                            width: width * 0.9,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromARGB(255, 19, 21, 34),
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  "Assets/Icons/upload.png",
                                  width: 45,
                                  height: 45,
                                ),
                                Text(
                                  "Upload File",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontFamily: 'Urbanist',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
              ),
            ),
            Spacer(),
            Center(
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 75,
                  width: width * 0.9,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 19, 21, 34),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        "Assets/Icons/next.png",
                        width: 45,
                        height: 45,
                      ),
                      Text(
                        "Berikutnya",
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Urbanist',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
