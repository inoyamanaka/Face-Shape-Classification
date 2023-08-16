import 'package:face_shape/Datas/url_host.dart';
import 'package:face_shape/config/config.dart';
import 'package:face_shape/features/classification/presentation/pages/dev_menu_page.dart';
import 'package:face_shape/features/classification/presentation/pages/dev_menu_verification_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/top_decoration.dart';
import 'package:face_shape/widgets/custom_header_2.dart';
import 'package:face_shape/widgets/custom_media2.dart';
import 'package:face_shape/widgets/cutom_deskripsi_preprocess.dart';
import 'package:face_shape/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    final MyColors myColor = MyColors();
    final MyFonts myFonts = MyFonts();

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
            MaterialPageRoute(builder: (context) => DevMenuPage()),
          );
          return false;
        },
        child: Container(
          child: Stack(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: size.height * 0.99,
                width: size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BackButtonUpload(context),
                      const SizedBox(height: 15),
                      PageTitlePreprocessing()
                          .animate()
                          .slideY(begin: 1, end: 0),
                      ImageExample().animate().slideY(begin: 1, end: 0),
                      const SizedBox(height: 20),
                      PageTitleModelParams().animate().slideY(begin: 1, end: 0),
                      const SizedBox(height: 10),
                      ParamsInputForm(myFonts, myColor, tli)
                          .animate()
                          .slideY(begin: 1, end: 0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
            ]),
            DevNextButton(
                sendDropdownValue, sendTextFieldEpoch, sendTextFieldBatch),
            LoadingOverlay(
              text: "Mohon Tunggu Sebentar...",
              isLoading: _isLoading,
            )
          ]),
        ),
      ),
    );
  }

  Positioned DevNextButton(
      Future<void> sendDropdownValue(String dropdownValue),
      Future<void> sendTextFieldEpoch(String textFieldValue),
      Future<void> sendTextFieldBatch(String textFieldValue)) {
    return Positioned(
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
    );
  }

  Container ParamsInputForm(MyFonts myFonts, MyColors myColor, double tli) {
    return Container(
      height: 600,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            OptimizerTitle(myFonts),
            SizedBox(height: 10),
            OptimizerInput(myColor),
            SizedBox(height: 10),
            EpochTitle(myFonts),
            SizedBox(height: 10),
            EpochInput(tli),
            SizedBox(height: 10),
            BatchSizeTitle(myFonts),
            SizedBox(height: 10),
            BatchSizeInput(),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  Align BatchSizeTitle(MyFonts myFonts) {
    return Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Batch size",
          style: myFonts.secondary,
        ));
  }

  Align EpochTitle(MyFonts myFonts) {
    return Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Jumlah Epoch",
          style: myFonts.secondary,
        ));
  }

  Align OptimizerTitle(MyFonts myFonts) {
    return Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Optimizers",
          style: myFonts.secondary,
        ));
  }

  TextField BatchSizeInput() {
    return TextField(
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
    );
  }

  TextField EpochInput(double tli) {
    return TextField(
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
    );
  }

  Center OptimizerInput(MyColors myColor) {
    return Center(
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

          focusColor: myColor.primary,
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
    );
  }

  Container PageTitleModelParams() {
    return Container(
      alignment: Alignment.topLeft,
      width: 250,
      height: 50,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 19, 21, 34),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
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
    );
  }

  SingleChildScrollView ImageExample() {
    return SingleChildScrollView(
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
                  SizedBox(height: 10),
                  FaceCroppingCard(
                      deskripsi:
                          "Facial landmark merupakan proses pemberian landmark pada area-area yang merepresentasikan bagian-bagian wajah",
                      gambar: "Assets/Images/facial_landmark.png",
                      tahap: "facial_landmark"),
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
                      gambar: "Assets/Images/facial_landmark.png",
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
                    gambar: "Assets/Images/landmark_extraction.png",
                    tahap: "landmark_extraction",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container PageTitlePreprocessing() {
    return Container(
      alignment: Alignment.topLeft,
      width: 250,
      height: 50,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 19, 21, 34),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
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
    );
  }

  CustomBackButton BackButtonUpload(BuildContext context) {
    return CustomBackButton(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: DevMenuPage()),
          // ),
        );
      },
    );
  }
}
