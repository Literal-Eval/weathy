import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Header extends StatelessWidget {
  Header({
    required this.city,
    required this.onPressed,
    Key? key,
  }) : super(key: key) {
    final rawDate = DateTime.now();
    date = DateFormat('EEEE, MMM d').format(rawDate) + 'th';
  }

  final String city;
  late final String date;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          child: const Icon(
            Icons.menu_open,
            color: Colors.white,
            size: 35,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              city,
              style: const TextStyle(fontSize: 30, letterSpacing: 1.1),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              date,
              style: const TextStyle(fontSize: 14, letterSpacing: 1.1),
            ),
          ],
        ),
        TextButton(
          onPressed: onPressed,
          child: const Icon(
            Icons.search,
            color: Colors.white,
            size: 35,
          ),
        ),
      ],
    );
  }
}
