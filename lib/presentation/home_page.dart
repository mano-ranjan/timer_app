import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = MethodChannel('samples.flutter.dev/methodTimer');
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod("getBatteryLevel");
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  int timeVar = 00;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 100,
            ),
            Text('$timeVar : $timeVar'),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: InkWell(
                onTap: () {
                  setState(() {
                    timeVar = timeVar + 1;
                  });
                },
                child: ClipOval(
                  child: Image.asset(
                    'assets/meditation_logo.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // child: ,
            ),
            InkWell(
              onTap: () {
                _getBatteryLevel();
              },
              child: const Text('get battery level'),
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}
