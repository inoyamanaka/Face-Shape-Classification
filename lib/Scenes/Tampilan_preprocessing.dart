import 'package:face_shape/Datas/color.dart';
import 'package:face_shape/Datas/url_host.dart';
import 'package:face_shape/Scenes/Tampilan_upload_dataset.dart';
import 'package:face_shape/Scenes/Tampilan_verification.dart';
import 'package:face_shape/widgets/custom_backbtn.dart';
import 'package:face_shape/widgets/custom_header_2.dart';
import 'package:face_shape/widgets/custom_media2.dart';
import 'package:face_shape/widgets/cutom_deskripsi_preprocess.dart';
import 'package:face_shape/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

class PreprocessingScreen extends StatefulWidget {
  const PreprocessingScreen({super.key});

  @override
  State<PreprocessingScreen> createState() => _PreprocessingScreenState();
}

class _PreprocessingScreenState extends State<PreprocessingScreen> {
  String _selectedOption = "adam";
  String _numberepoch = "3";
  String _numberbatch = "16";
  bool _isLoading = false;

  List<String> _options = [
    'adam',
    'RMSprop',
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width; // lebar layar
    final double height = size.height; // tinggi l

    double tli = 400;

    Future<void> sendDropdownValue(String dropdownValue) async {
      final url = ApiUrl.Url_optimizer;
      final response = await http.post(Uri.parse(url), body: {
        'value': dropdownValue,
      });
      setState(() {
        _isLoading = true;
      });

      if (response.statusCode == 200) {
        print('Dropdown value sent successfully');
      } else {
        print(response.statusCode);
        print('Failed to send dropdown value');
      }
    }

    Future<void> sendTextFieldEpoch(String textFieldValue) async {
      final url = ApiUrl.Url_epoch;
      final response =
          await http.post(Uri.parse(url), body: {'value': textFieldValue});
      if (response.statusCode == 200) {
        print('Textfield value sent successfully');
      } else {
        print('Failed to send textfield value');
      }
    }

    Future<void> sendTextFieldBatch(String textFieldValue) async {
      final url = ApiUrl.Url_batch_size;
      final response =
          await http.post(Uri.parse(url), body: {'value': textFieldValue});
      if (response.statusCode == 200) {
        print('Textfield value sent successfully');
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: VerifScreen(),
          ),
        );
      } else {
        print('Failed to send textfield value');
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UploadDataScreen()),
          );
          return false;
        },
        child: Container(
          child: Stack(children: [
            Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.99,
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
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
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
                                        CustomHeader2(
                                            isi: "Landmark Extraction"),
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
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 600,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Optimizers",
                                        style: TextStyle(
                                            color: PrimColor.primary,
                                            fontSize: 16,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w700),
                                      )),
                                  SizedBox(height: 10),
                                  Center(
                                    child: Container(
                                      // color: Colors.black,
                                      // width: 120,
                                      child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        hint: Text('Select an option'),
                                        value: _selectedOption,
                                        isExpanded: true,
                                        // itemHeight: BorderSide.strokeAlignInside,
                                        isDense: true,
                                        // dropdownColor: Colors.,

                                        focusColor: PrimColor.primary,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedOption = newValue!;
                                            // sendDropdownValue(_selectedOption);
                                          });
                                        },
                                        items: _options.map((option) {
                                          return DropdownMenuItem(
                                            child: Text(option),
                                            value: option,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Jumlah Epoch",
                                        style: TextStyle(
                                            color: PrimColor.primary,
                                            fontSize: 16,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w700),
                                      )),
                                  SizedBox(height: 10),
                                  TextField(
                                    decoration: InputDecoration(
                                        hintText: "3",
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              tli = 1000;
                                            });
                                          },
                                          icon: const Icon(Icons.clear),
                                        ),
                                        border: OutlineInputBorder()),
                                    onChanged: (newValue) {
                                      // Memanggil fungsi sendTextFieldValue
                                      _numberepoch = newValue;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Batch size",
                                        style: TextStyle(
                                            color: PrimColor.primary,
                                            fontSize: 16,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w700),
                                      )),
                                  SizedBox(height: 10),
                                  TextField(
                                    decoration: InputDecoration(
                                        hintText: "Minimal 16",
                                        suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.clear),
                                        ),
                                        border: OutlineInputBorder()),
                                    onChanged: (newValue) {
                                      _numberbatch = newValue;
                                    },
                                  ),
                                  SizedBox(height: 70),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                ]),
            Positioned(
              bottom: 10,
              left: 20,
              right: 20,
              child: CustomButton2(
                isi: "Berikutnya",
                onTap: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  // _isLoading = true;
                  sendDropdownValue(_selectedOption);
                  sendTextFieldEpoch(_numberepoch);
                  sendTextFieldBatch(_numberbatch);
                },
              ),
            ),
            LoadingOverlay(
              text: "Mohon Tunggu Sebentar...",
              isLoading: _isLoading,
            )
          ]),
        ),
      ),
    );
  }
}
