class WeatherForecastData {
  WeatherForecastData(Map responseData)
      : time = responseData['dt_txt'],
        // timeZone = responseData['timezone'],
        temperature = double.parse("${responseData['main']['feels_like']}"),
        feelsLikeTemperature =
            double.parse("${responseData['main']['feels_like']}"),
        minTemperature = double.parse("${responseData['main']['feels_like']}"),
        maxTemperature = double.parse("${responseData['main']['feels_like']}"),
        pressure = double.parse("${responseData['main']['pressure']}"),
        humidity = double.parse("${responseData['main']['humidity']}"),
        weatherMain = responseData['weather'][0]['main'],
        weatherDescription = responseData['weather'][0]['description'],
        clouds = double.parse("${responseData['clouds']['all']}"),
        wind = double.parse("${responseData['wind']['speed']}"),
        visibility = double.parse("${responseData['visibility']}");

  final String time;
  // final int timeZone;
  final String weatherMain;
  final String weatherDescription;
  final double temperature;
  final double feelsLikeTemperature;
  final double minTemperature;
  final double maxTemperature;
  final double pressure;
  final double humidity;
  final double visibility;
  final double clouds;
  final double wind;

  static int timeZone = 0;
}
