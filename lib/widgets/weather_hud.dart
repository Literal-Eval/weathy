import 'package:flutter/material.dart';
import 'package:weathy/models/weather_data.dart';
import 'package:weathy/models/weather_info_icon.dart';

class WeatherHUD extends StatelessWidget {
  WeatherHUD({
    required this.weatherData,
    this.celcius = true,
    this.dark = false,
    Key? key,
  })  : temperature = (weatherData.temperature - 273.15).toStringAsFixed(1),
        super(key: key);

  final WeatherData weatherData;
  final bool celcius;
  final String temperature;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          mainAxisAlignment: MainAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              temperature,
              style: TextStyle(
                fontSize: 100,
                color: dark ? Colors.black87 : Colors.white,
              ),
            ),
            Text(
              celcius ? '\u2103' : '\u2109',
              style: TextStyle(
                fontSize: 30,
                color: dark ? Colors.black87 : Colors.white,
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: WeatherInfoIcon.getIcon(
                weatherCode: weatherData.weatherMain,
                time: DateTime.now(),
                dark: dark,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              weatherData.weatherMain,
              style: TextStyle(
                fontSize: 20,
                color: dark ? Colors.black87 : Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.pin_drop_outlined,
                  color: dark ? Colors.black87 : Colors.white,
                ),
                Text(
                  weatherData.humidity.toStringAsFixed(0) + '%',
                  style: TextStyle(
                    fontSize: 16,
                    color: dark ? Colors.black87 : Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.settings,
                  color: dark ? Colors.black87 : Colors.white,
                ),
                Text(
                  weatherData.pressure.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: dark ? Colors.black87 : Colors.white,
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
