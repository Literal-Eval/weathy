import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CheckPermissions extends StatelessWidget {
  const CheckPermissions({
    required this.waitText,
    Key? key,
  }) : super(key: key);

  final String waitText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
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
          SizedBox(
            height: 100,
            child: Text(
              waitText,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
