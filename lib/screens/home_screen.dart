import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weathy/screens/main_screen.dart';
import 'package:location/location.dart' as loc;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void managePermissions() async {
    if (await Permission.location.request().isGranted) {
      // Pretty

      if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
        move();
      } else {
        final loc.Location location = loc.Location();

        bool _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
        }

        move();
      }
    }
  }

  void move() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    managePermissions();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 600,
              height: 600,
              child: Lottie.asset(
                'assets/anim/settings_lottie.json',
              ),
            ),
            const SizedBox(
              height: 100,
              child: Text(
                'Checking for permissions...',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
