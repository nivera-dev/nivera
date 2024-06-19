import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:niveraapp/constants.dart';
import 'package:niveraapp/global/global.dart';
import 'package:niveraapp/models/sensors.dart';
import 'package:niveraapp/widgets/custom_text_form_field.dart';

class EditSensorPage extends StatefulWidget {
  final Sensors model;
  const EditSensorPage({super.key, required this.model});

  @override
  State<EditSensorPage> createState() => _EditSensorPageState();
}

class _EditSensorPageState extends State<EditSensorPage> {

  TextEditingController sensorValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Sensor Value"),
        actions: [
          IconButton(
            onPressed: () {
              updateSensorValue(sensorValueController.text.toString());
              Navigator.pop(context);
              },
            icon: const Icon(Icons.update),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text("Edit sensor data here for ${widget.model.sensorName}", style: const TextStyle(color: ColorPalette.mainColor),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFormField(
              controller: sensorValueController,
              hintText: "Type new value",
              obscureText: false,
              textInputType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }

  void updateSensorValue(String newValue) {
    FirebaseFirestore.instance
        .collection("")
        .doc(sharedPreferences!.getString(""))
        .collection("")
        .doc(widget.model.sensorID!.toString())
        .update({"": newValue});
  }
}
