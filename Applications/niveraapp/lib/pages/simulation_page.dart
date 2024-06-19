import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:niveraapp/constants.dart';
import 'package:niveraapp/global/global.dart';
import 'package:niveraapp/models/sensors.dart';
import 'package:niveraapp/pages/add_sensor_page.dart';
import 'package:niveraapp/widgets/progress_bar.dart';
import 'package:niveraapp/widgets/sensor_card.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';

class SimulationPage extends StatefulWidget {
  const SimulationPage({super.key});

  @override
  State<SimulationPage> createState() => _SimulationPageState();
}

class _SimulationPageState extends State<SimulationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: ColorPalette.whiteFloor,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 5.0, left: 5.0, right: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "nivera",
                style: mRobotoRegular.copyWith(
                  fontSize: 40.0,
                  color: ColorPalette.mainColor,
                ),
              ),
              Text(
                "simu",
                style: mRobotoRegular.copyWith(
                  fontSize: 25.0,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const AddSensorPage()));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(ColorPalette.subColor),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0)
                            ),
                          )
                      ),
                      child: Container(
                          alignment: Alignment.center,
                          height: 100.0,
                          child: const Text("Add", style: TextStyle(fontSize: 15.0, color: Colors.white),)
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0)
                            ),
                          )
                      ),
                      child: Container(
                          alignment: Alignment.center,
                          height: 100.0,
                          child: const Text("Refresh", style: TextStyle(fontSize: 15.0, color: Colors.white),)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User ID: ${sharedPreferences!.getString("")!}",
                    style: mRobotoMedium.copyWith(
                        color: Colors.grey,
                        fontSize: 13
                    ),
                  ),
                  Text(
                    "Api Key: ",
                    style: mRobotoMedium.copyWith(
                        color: Colors.grey,
                        fontSize: 13
                    ),
                  ),
                  Text(
                    "Database URL: ",
                    style: mRobotoMedium.copyWith(
                        color: Colors.grey,
                        fontSize: 13
                    ),
                  ),
                  Text(
                    "Project ID: ",
                    style: mRobotoMedium.copyWith(
                        color: Colors.grey,
                        fontSize: 13
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: ListTile(
              title: Text("*Double tap the card to edit sensor/actuator value."),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("").doc(sharedPreferences!.getString('')).collection('').snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                child: Center(
                  child: circularProgress(),
                ),
              )
                  : SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                itemBuilder: (context, index) {
                  Sensors model = Sensors.fromJson(
                    snapshot.data!.docs[index].data()!
                        as Map<String, dynamic>,
                  );
                  return SensorCardWidget(
                    model: model,
                    context: context,
                    onDelete: deleteSensor,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),
        ],
      ),
    );
  }

  void deleteSensor(String sensorId) {
    FirebaseFirestore.instance.collection('').doc(sharedPreferences!.getString('')).collection('').doc(sensorId).delete();
  }
}
