import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:weathet_app_bloc/logic/cubits/settings/settings_weather_cubit.dart';
import 'package:weathet_app_bloc/logic/cubits/weather/weather_cubit.dart';
import 'package:weathet_app_bloc/logic/repositories/weather_repository/weather_repository.dart';
import 'package:weathet_app_bloc/logic/service/https/weather_api_services.dart';
import 'package:weathet_app_bloc/presentation/screens/home_screen.dart';
import 'package:weathet_app_bloc/presentation/screens/search_secreen.dart';
import 'package:weathet_app_bloc/presentation/screens/settings.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(weatherApiServices: WeatherApiServices(client: Client())),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => WeatherCubit(weatherRepository: context.read<WeatherRepository>())),
          BlocProvider(create: (context) => SettingsWeatherCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.indigo),
          home:   const HomeScreen(),
          routes: {
            HomeScreen.routName: (context) => const HomeScreen(),
            SearchScreen.routName: (context) =>  SearchScreen(),
            WeatherSettings.routName: (context) => const WeatherSettings(),
          },
        ),
      ),
    );
  }
}
