import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherInfoIcon {
  static SvgPicture getIcon({
    required String weatherCode,
    required DateTime time,
    bool dark = true,
  }) {
    String path = 'assets/icons/Sunrise.svg';

    if (time.hour >= 5 && time.hour < 10) {
      switch (weatherCode) {
        case 'Clear':
          path = 'assets/icons/Sunrise.svg';
          break;
        case 'Clouds':
          path = 'assets/icons/Cloudy.svg';
          break;
        default:
          break;
      }
    } else if (time.hour >= 10 && time.hour < 17) {
      switch (weatherCode) {
        case 'Clear':
          path = 'assets/icons/Sun.svg';
          break;
        case 'Clouds':
          path = 'assets/icons/Cloudy-Sun.svg';
          break;
        default:
          break;
      }
    } else if (time.hour >= 17 && time.hour <= 19) {
      switch (weatherCode) {
        case 'Clear':
          path = 'assets/icons/Sunset.svg';
          break;
        case 'Clouds':
          path = 'assets/icons/Cloudy 2.svg';
          break;
        default:
          break;
      }
    } else {
      switch (weatherCode) {
        case 'Clear':
          path = 'assets/icons/Moon 2.svg';
          break;
        case 'Clouds':
          path = 'assets/icons/Cloudy-Moon.svg';
          break;
        default:
          break;
      }
    }

    return SvgPicture.asset(
      path,
      color: dark ? Colors.black : Colors.white,
    );
  }
}
