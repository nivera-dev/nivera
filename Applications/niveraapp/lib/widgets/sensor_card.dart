import 'package:flutter/material.dart';
import 'package:niveraapp/constants.dart';
import 'package:niveraapp/models/sensors.dart';
import 'package:niveraapp/pages/edit_sensor_page.dart';

class SensorCardWidget extends StatefulWidget {
  final Sensors? model;
  final BuildContext? context;
  final Function(String) onDelete;

  const SensorCardWidget({super.key, this.model, this.context, required this.onDelete});

  @override
  State<SensorCardWidget> createState() => _SensorCardWidgetState();
}

class _SensorCardWidgetState extends State<SensorCardWidget> {
  late String? sensorIDw;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditSensorPage(model: widget.model!),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6.0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.model!.sensorName!,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.mainColor,
                      ),
                    ),
                    const Icon(
                      Icons.sensors_sharp,
                      color: ColorPalette.mainColor,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Value: ${widget.model!.sensorValue!}",
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.onDelete(widget.model!.sensorID!);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(0.1),
                        child: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  "ID: ${widget.model!.sensorID!}",
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
