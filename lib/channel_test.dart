import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}

class HomePageState extends State<HomePage> {
  static final platform = MethodChannel("samples.flutter.io/battery");

  String _batteryLevel = "unkown battery level.";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'channel',
      home: Scaffold(
        appBar: AppBar(title: Text('title'),),
          body: MaterialButton(onPressed: () {
        _getBatteryLevel();
      },child: Text(_batteryLevel),textColor: Colors.red,color: Colors.green,),),
    );
  }

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = "battery level at $result %.";
    } on PlatformException catch (e) {
      batteryLevel = "failed to get battery level : '${e.message}'";
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}