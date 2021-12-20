import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weathy/models/weather.dart';
import 'package:weathy/models/location.dart';
import 'package:weathy/models/weather_data.dart';
import 'package:weathy/models/weather_forecast_data.dart';
import 'package:weathy/widgets/check_permissions.dart';
import 'package:weathy/widgets/header.dart';
import 'package:weathy/widgets/search_card.dart';
import 'package:weathy/widgets/weather_forecast_bar.dart';
import 'package:weathy/widgets/weather_hud.dart';
import 'package:location/location.dart' as loc;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Pretty

  final Location _location = Location();
  String _city = 'Loading';
  String _waitText = 'Checking for permissions...';

  bool _showSearchBar = false;
  bool _setUp = false;
  bool _loading = false;

  final Weather _weather = Weather();
  WeatherData _weatherData = WeatherData(WeatherData.defaultData);
  final List<WeatherForecastData> _weatherForecastData = [];

  late final Timer _updateTimer;

  @override
  void initState() {
    super.initState();

    fetchData();

    _updateTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      if (_loading) return;
      fetchData();
    });
  }

  void fetchData() async {
    await managePermissions();
    getLocation();
  }

  void fetchDataWithCity(String cityName) async {
    setState(() {
      _showSearchBar = false;
      _setUp = false;
      _loading = true;
    });

    final _rawWeather = await _weather.getWeatherWithCity(cityName);
    final _rawForecast = await _weather.getForecastWithCity(cityName);

    int responseCode = int.parse('${_rawWeather['cod']}');

    if (responseCode == 404) {
      setState(() {
        _loading = false;
        _setUp = true;
      });

      showDialog(
        context: context,
        builder: (context) => ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 100, maxHeight: 50),
          child: AlertDialog(
            elevation: 5,
            title: const Text('Error'),
            titleTextStyle: const TextStyle(
              color: Colors.red,
              fontSize: 25,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Okay',
                ),
              ),
            ],
            content: SizedBox(
              height: 50,
              child: Center(
                child: Text('$cityName not found.'),
              ),
            ),
          ),
        ),
      );
    } else if (responseCode == 200) {
      _weatherForecastData.clear();
      WeatherForecastData.timeZone = _rawForecast['city']['timezone'];

      for (int i = 0; i < _rawForecast['cnt'].toInt(); i++) {
        _weatherForecastData.add(WeatherForecastData(_rawForecast['list'][i]));
      }

      setState(() {
        _loading = false;
        _setUp = true;

        _weatherData = WeatherData(_rawWeather);
        _city = _weatherData.cityName;
      });
    }
  }

  Future<void> managePermissions() async {
    setState(() {
      _loading = true;
      _setUp = false;
      _waitText = 'Checking for permissions...';
    });

    final loc.Location location = loc.Location();

    if (await Permission.location.request().isGranted &&
            await Permission.locationWhenInUse.serviceStatus.isEnabled ||
        await location.requestService()) {
      setState(() {
        _waitText = 'Loading...';
      });
    }
  }

  void getLocation() async {
    await _location.getLocation();
    _weather.setCoords(
        _location.position.latitude, _location.position.longitude);
    final _rawWeather = await _weather.getWeather();

    setState(() {
      _weatherData = WeatherData(_rawWeather);
      _city = _weatherData.cityName;
    });

    final _rawForecast = await _weather.getForecast();

    _weatherForecastData.clear();
    WeatherForecastData.timeZone = _rawForecast['city']['timezone'];
    for (int i = 0; i < _rawForecast['cnt'].toInt(); i++) {
      _weatherForecastData.add(WeatherForecastData(_rawForecast['list'][i]));
    }

    setState(() {
      _setUp = true;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _updateTimer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          child: Column(
            children: [],
          ),
        ),
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              color: Colors.white,
            ),
            Stack(
              alignment: const Alignment(0, 0),
              children: [
                Image.asset(
                  'assets/images/winter_morning.png',
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  child: Center(
                    child: WeatherHUD(
                      weatherData: _weatherData,
                      dark: false,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 70,
              child: Header(
                city: _city,
                onPressed: () {
                  setState(() {
                    _showSearchBar = true;
                  });
                },
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: WeatherForecastBar(
                city: _city,
                forecastDataList: _weatherForecastData,
              ),
            ),
            Builder(builder: (context) {
              if (_showSearchBar) {
                return Positioned.fill(
                  left: 0,
                  right: 0,
                  // top: 70,
                  child: SearchCard(
                    onPopUp: () {
                      setState(() {
                        _showSearchBar = false;
                      });
                    },
                    onSearch: fetchDataWithCity,
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
            Builder(builder: (context) {
              if (!_setUp) {
                return Positioned.fill(
                  left: 0,
                  right: 0,
                  // top: 70,
                  child: CheckPermissions(
                    waitText: _waitText,
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
          ],
        ),
      ),
    );
  }
}
