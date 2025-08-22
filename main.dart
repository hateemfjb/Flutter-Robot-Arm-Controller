
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robot Arm Controller',
      home: RobotControllerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RobotControllerPage extends StatefulWidget {
  @override
  _RobotControllerPageState createState() => _RobotControllerPageState();
}

class _RobotControllerPageState extends State<RobotControllerPage> {
  double motor1 = 90;
  double motor2 = 90;
  double motor3 = 90;
  double motor4 = 90;
  List poses = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> savePose() async {
    var response = await http.post(
      Uri.parse("http://localhost/robot_api/save_pose.php"),
      body: {
        "motor1": motor1.round().toString(),
        "motor2": motor2.round().toString(),
        "motor3": motor3.round().toString(),
        "motor4": motor4.round().toString(),
      },
    );
    if (response.statusCode == 200) {
      loadData();
    }
  }

  Future<void> loadData() async {
    var response = await http.get(Uri.parse("http://localhost/robot_api/get_run_pose.php"));
    if (response.statusCode == 200) {
      setState(() {
        poses = json.decode(response.body);
      });
    }
  }

  Future<void> runPose(int id) async {
    await http.post(
      Uri.parse("http://localhost/robot_api/update_status.php"),
      body: {"id": id.toString()},
    );
    loadData();
  }

  Future<void> deletePose(int id) async {
    await http.post(
      Uri.parse("http://localhost/robot_api/delete_pose.php"),
      body: {"id": id.toString()},
    );
    loadData();
  }

  Widget buildSlider(String label, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label: ${value.round()}", style: TextStyle(fontWeight: FontWeight.bold)),
        Slider(
          value: value,
          min: 0,
          max: 180,
          divisions: 180,
          label: value.round().toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Robot Arm Controller")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset("assets/robot_arm.png", height: 200),
            SizedBox(height: 10),
            buildSlider("Motor 1", motor1, (value) => setState(() => motor1 = value)),
            buildSlider("Motor 2", motor2, (value) => setState(() => motor2 = value)),
            buildSlider("Motor 3", motor3, (value) => setState(() => motor3 = value)),
            buildSlider("Motor 4", motor4, (value) => setState(() => motor4 = value)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: savePose, child: Text("Save")),
                ElevatedButton(
                    onPressed: () => setState(() {
                          motor1 = 90;
                          motor2 = 90;
                          motor3 = 90;
                          motor4 = 90;
                        }),
                    child: Text("Reset")),
              ],
            ),
            SizedBox(height: 20),
            Text("Saved Poses", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 10),
            Table(
              border: TableBorder.all(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1),
                5: FlexColumnWidth(1),
              },
              children: [


TableRow(
                  decoration: BoxDecoration(color: Colors.grey[300]),
                  children: [
                    Center(child: Text("M1")),
                    Center(child: Text("M2")),
                    Center(child: Text("M3")),
                    Center(child: Text("M4")),
                    Center(child: Text("Run")),
                    Center(child: Text("Delete")),
                  ],
                ),
                ...poses.map((pose) {
                  return TableRow(
                    children: [
                      Center(child: Text(pose['motor1'].toString())),
                      Center(child: Text(pose['motor2'].toString())),
                      Center(child: Text(pose['motor3'].toString())),
                      Center(child: Text(pose['motor4'].toString())),
                      Center(
                        child: IconButton(
                          icon: Icon(Icons.play_arrow, color: Colors.green),
                          onPressed: () => runPose(int.parse(pose['id'])),
                        ),
                      ),
                      Center(
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deletePose(int.parse(pose['id'])),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}