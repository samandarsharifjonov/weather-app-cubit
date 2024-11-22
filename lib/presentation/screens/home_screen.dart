import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weathet_app_bloc/logic/cubits/settings/settings_weather_cubit.dart';

import 'package:weathet_app_bloc/logic/cubits/weather/weather_cubit.dart';
import 'package:weathet_app_bloc/presentation/screens/search_secreen.dart';
import 'package:weathet_app_bloc/presentation/screens/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = 'london';

  @override
  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message.toLowerCase().contains('not found')
            ? "NOT FOUND"
            : 'ERROR :( '),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(HomeScreen.routName);
              },
              child: const Text("OK"))
        ],
      ),
    );
  }

  String showTemperature(double temperature) {
    final numFormat = NumberFormat('00');
    final tempUnit = context.watch<SettingsWeatherCubit>().state.tempUnit;
    if (tempUnit == TempUnits.fahrenheit) {
      return '${numFormat.format(temperature * 9 / 5 + 32)}°F';
    }
    return '${numFormat.format(temperature)}°C';
  }

  @override
  void initState() {
    // TODO: implement initState
    _getWeather();
    super.initState();
  }

  void _getWeather() {
    context.read<WeatherCubit>().getWeather(city);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          title: const Text(
            "Weather app",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      final _city = await Navigator.of(context).pushNamed(SearchScreen.routName);
                      print(city);
                      if (_city != null) {
                        city = _city.toString();
                        _getWeather();
                      }
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 25,
                      color: Colors.white,
                    )),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(WeatherSettings.routName);
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 25,
                    ))
              ],
            )
          ],
        ),
        body: BlocListener<WeatherCubit, WeatherState>(
          listener: (context, state) {
            if (state is WeatherError) {
              showErrorDialog(context, state.errorMessage);
            }
          },
          child: BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitial) {
                return const Center(
                  child: Text("Select a City"),
                );
              }
              if (state is WeatherLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is WeatherLoaded) {
                final weather = state.weather;
                print('Main ------------> > >${weather.main}');
                String imgPath = '';
                String weatherIcon = '';
                if (weather.main.toLowerCase().contains('clouds')) {
                  imgPath = 'assets/img/clouds.png';
                  weatherIcon = 'assets/weather_icon/cloud.png';
                } else if (weather.main.toLowerCase().contains('rain')) {
                  imgPath = 'assets/img/rains.png';
                  weatherIcon = 'assets/weather_icon/rain.png';
                } else if (weather.main.toLowerCase().contains('clear')) {
                  imgPath = 'assets/img/clearSky.png';
                  weatherIcon = 'assets/weather_icon/img_1.png';
                } else if (weather.main.toLowerCase().contains('snow')) {
                  imgPath = 'assets/img/snow.png';
                  weatherIcon = 'assets/weather_icon/snow.png';
                } else {
                  imgPath = 'assets/img/night.png';
                  weatherIcon = 'assets/weather_icon/smoke.png';
                }

                return Stack(
                  children: [
                    Image.asset(
                      imgPath,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: h * 0.02, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${state.weather.city.toUpperCase()}',
                                style: const TextStyle(
                                    fontSize: 45, color: Colors.white)),
                            Text(state.weather.description.toString(),
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            Row(
                              children: [
                                Text(showTemperature(state.weather.temp),
                                    style: const TextStyle(
                                        fontSize: 50, color: Colors.white)),
                                const SizedBox(
                                  width: 4,
                                ),
                                /*  Image.network(
                                  "https://openweathermap.org/img/wn/${state.weather.icon}@2x.png",
                                  height: 60,
                                  width: 60,
                                ),*/

                                Image.asset(
                                  weatherIcon,
                                  width: 70,
                                  height: 70,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Speed: ${weather.wind}',
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  "assets/weather_icon/speed.png",
                                  height: 20,
                                  width: 20,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text('Humidity: ${weather.humidity}',
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  "assets/weather_icon/humidity.png",
                                  height: 20,
                                  width: 20,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
              return Container();
            },
          ),
        ));
  }
}
