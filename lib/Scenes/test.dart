import 'dart:async';
import 'dart:convert';
import 'package:face_shape/Datas/url_host.dart';
import 'package:face_shape/widgets/loading.dart';
import 'package:face_shape/widgets/loading2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _progress = 0;
  String _name = "name";
  bool _isLoading = false;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (_) => _fetchProgress());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _doProgress() async {
    final response = await http.get(Uri.parse(ApiUrl.Url_preprocessing));
    final data = json.decode(response.body);
    setState(() {
      _isLoading = true;
      _progress = data['progress'];
      _name = data['name'];
    });
  }

  Future<void> _fetchProgress() async {
    final response = await http.get(Uri.parse(ApiUrl.Url_fetch_progress));
    final data = json.decode(response.body);
    setState(() {
      _progress = data['progress'];
      _name = data['name'];
    });
  }

  Future<Map<String, dynamic>> getDataFromServer() async {
    // Lakukan request ke server
    final response = await http.get(Uri.parse(ApiUrl.Url_total_files));

    // Parse respons JSON
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception(Text("LOOO"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // LinearPercentIndicator(
          //   width: 300.0,
          //   lineHeight: 8.0,
          //   // percent: 0.9,
          //   percent: (_progress / 288),
          //   progressColor: Colors.blue,
          // ),
          // SizedBox(height: 24.0),
          // ElevatedButton(
          //   onPressed: _doProgress,
          //   child: Text('Refresh Progress'),
          // ),
          LoadingOverlay2(
            isLoading: true,
            text: 'Progress $_name : $_progress',
            name: _name,
          ),
        ],
      ),
    );
  }
}
