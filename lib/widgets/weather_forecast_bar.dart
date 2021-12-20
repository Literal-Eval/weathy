import 'package:flutter/material.dart';
import 'package:weathy/models/weather_forecast_data.dart';
import 'package:weathy/models/weather_info_icon.dart';

class WeatherForecastBar extends StatelessWidget {
  const WeatherForecastBar(
      {required this.city, required this.forecastDataList, Key? key})
      : super(key: key);

  final String city;
  final List<WeatherForecastData> forecastDataList;

  DateTime getTime(String time, int timeZone) {
    return DateTime.parse(time).add(Duration(seconds: timeZone));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Forecast',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                city,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 400,
            height: 120,
            child: ListView(
              itemExtent: 80,
              scrollDirection: Axis.horizontal,
              children: [
                ...forecastDataList
                    .map(
                      (forecastData) => WeatherIcon(
                        time: getTime(
                            forecastData.time, WeatherForecastData.timeZone),
                        temperature: forecastData.temperature,
                        weatherCode: forecastData.weatherMain,
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({
    required this.time,
    required this.weatherCode,
    required this.temperature,
    Key? key,
  }) : super(key: key);

  final DateTime time;
  final double temperature;
  final String weatherCode;

  String getTime() {
    if (time.hour <= 12) {
      return '${time.hour}:${time.minute} am';
    }

    return '${time.hour - 12}:${time.minute} pm';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          getTime(),
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 80,
          height: 60,
          child: WeatherInfoIcon.getIcon(
            weatherCode: weatherCode,
            time: time,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          (temperature - 273.15).toStringAsFixed(1) + ' \u2103',
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
