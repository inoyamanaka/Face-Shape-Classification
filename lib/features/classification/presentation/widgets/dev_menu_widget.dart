import 'package:dotted_border/dotted_border.dart';
import 'package:face_shape/features/classification/domain/usecases/upload_dataset.dart';
import 'package:face_shape/features/classification/presentation/widgets/upload_progress.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iconsax/iconsax.dart';

class DevMenuWidget extends StatelessWidget {
  const DevMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  InkWell ButtonUploadDataset(BuildContext context) {
    bool isSucces = false;
    ValueNotifier<double> loadingControllerP = ValueNotifier<double>(0.0);
    return InkWell(
      onTap: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles();
        String? path = result!.files.first.path;

        final uploadDataset = UploadDataset();
        isSucces = await uploadDataset.call(path!, loadingControllerP);

        isSucces == true ? SuccesUpload(context) : Container();
      },
      child: BelumTau(),
    );
  }

  Padding BelumTau() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(10),
          dashPattern: [10, 4],
          strokeCap: StrokeCap.round,
          color: Color.fromARGB(255, 19, 21, 34),
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.blue.shade50.withOpacity(.3),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.folder_open,
                  color: Color.fromARGB(255, 19, 21, 34),
                  size: 40,
                ),
                SizedBox(height: 15),
                Text(
                  'Select your file',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ),
        ));
  }
}
