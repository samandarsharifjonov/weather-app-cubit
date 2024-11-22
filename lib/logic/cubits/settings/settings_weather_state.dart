part of 'settings_weather_cubit.dart';

enum TempUnits {
  celsius,
  fahrenheit,
}

@immutable
 class SettingsWeatherState {
  final TempUnits? tempUnit;
  const SettingsWeatherState({this.tempUnit});
}

