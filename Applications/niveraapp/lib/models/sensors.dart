
class Sensors {
  String? sensorID;
  String? sensorName;
  String? sensorValue;

  Sensors({this.sensorID, this.sensorName, this.sensorValue});

  Sensors.fromJson(Map<String, dynamic> json) {
    sensorID = json["sensorID"];
    sensorName = json["sensorName"];
    sensorValue = json["sensorValue"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["sensorID"] = sensorID;
    data["sensorName"] = sensorName;
    data["sensorValue"] = sensorValue;

    return data;
  }
}

