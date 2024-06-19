import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:niveraapp/constants.dart';
import 'package:niveraapp/global/global.dart';
import 'package:niveraapp/widgets/custom_text_form_field.dart';
import 'package:niveraapp/widgets/error_dialog.dart';
import 'package:niveraapp/widgets/progress_bar.dart';

class AddSensorPage extends StatefulWidget {
  const AddSensorPage({super.key});

  @override
  State<AddSensorPage> createState() => _AddSensorPageState();
}

class _AddSensorPageState extends State<AddSensorPage> {

  TextEditingController sensorNameController = TextEditingController();
  TextEditingController sensorValueController = TextEditingController();

  String uniqueIDName = DateTime.now().microsecondsSinceEpoch.toString();
  bool uploading = false;


  sensorUploadForm() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sensor Details", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          TextButton(
            onPressed: uploading ? null : () => validateUploadForm(),
            child: Text("Upload", style: mRobotoBold.copyWith(color: Colors.white)),
          )
        ],
      ),
      body: ListView(
        children: [
          uploading == true ? linearProgress() : const Text(""),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFormField(
                controller: sensorNameController,
                hintText: "Sensor Name",
                obscureText: false,
                textInputType: TextInputType.text
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.green,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFormField(
                controller: sensorValueController,
                hintText: "Sensor Value (For TESTING)",
                obscureText: false,
                textInputType: TextInputType.text
            ),
          ),

          const SizedBox(
            height: 200.0,
          ),

          SizedBox(
            height: 200.0,
            child: Image.asset("assets/renew.png"),
          )



        ],
      ),
    );
  }


  clearMenuUploadForm() {
    setState(() {
      sensorNameController.clear();
      sensorValueController.clear();
    });
  }

  validateUploadForm() {
    if(sensorNameController.text.isNotEmpty && sensorValueController.text.isNotEmpty) {
      setState(() {
        uploading = true;
      });
      saveInfo();
      Navigator.pop(context);
    }else {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: "Please fill all fields.",
            );
          }
      );
    }
  }


  saveInfo() {
    final ref = FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("sensors");

    ref.doc(uniqueIDName).set({
      "sensorID" : uniqueIDName,
      "sensorName" : sensorNameController.text.toString(),
      "sensorValue" : sensorValueController.text.toString(),
      "publishedDate" : DateTime.now(),
    });

    clearMenuUploadForm();

    setState(() {
      uniqueIDName = DateTime.now().microsecondsSinceEpoch.toString();
      uploading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return sensorUploadForm();
  }
}
