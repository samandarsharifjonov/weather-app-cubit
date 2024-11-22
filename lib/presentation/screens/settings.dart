import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathet_app_bloc/logic/cubits/settings/settings_weather_cubit.dart';

class WeatherSettings extends StatelessWidget {
  const WeatherSettings({super.key});

  static const routName = '/settings';

  @override
  Widget build(BuildContext context) {
    final settingsWeather = context.read<SettingsWeatherCubit>();
    final temperature = context.watch<SettingsWeatherCubit>().state.tempUnit == TempUnits.celsius ? true : false;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.teal,
      ),
      body: Card(
        child: ListTile(
          title: const Text('Temperature unit'),
          subtitle: const Text("Celsius and fahrenheit"),
          trailing: Switch.adaptive(
              value: temperature,
              onChanged: (value) {
                settingsWeather.toggleTemperature();
              }),
        ),
      ),
    );
  }
}
