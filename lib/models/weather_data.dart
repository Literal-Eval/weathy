class WeatherData {
  WeatherData(Map responseData)
      : cityName = responseData['name'],
        countryName = responseData['sys']['country'],
        latitude = double.parse('${responseData['coord']['lat']}'),
        longitude = double.parse('${responseData['coord']['lon']}'),
        temperature = double.parse('${responseData['main']['temp']}'),
        feelLikeTemperature =
            double.parse('${responseData['main']['feels_like']}'),
        pressure = double.parse('${responseData['main']['pressure']}'),
        humidity = double.parse('${responseData['main']['humidity']}'),
        weatherMain = responseData['weather'][0]['main'],
        weatherDescription = responseData['weather'][0]['description'];

  static const Map defaultData = {
    'name': 'loading',
    'sys': {'country': 'loading'},
    'coord': {'lat': 0.0, 'lon': 0.0},
    'main': {
      'temp': 273.15,
      'feels_like': 0.0,
      'pressure': 0.0,
      'humidity': 0.0
    },
    'weather': [
      {'main': 'loading', 'description': 'loading'}
    ]
  };

  final String cityName;
  final String countryName;
  final double latitude;
  final double longitude;
  final double temperature;
  final double feelLikeTemperature;
  final String weatherMain;
  final String weatherDescription;
  final double pressure;
  final double humidity;
}
