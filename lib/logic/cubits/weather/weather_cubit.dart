import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weathet_app_bloc/data/models/weather.dart';

import '../../repositories/weather_repository/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherCubit({required this.weatherRepository}) : super(WeatherInitial());

  Future<void> getWeather(String city)async{
    emit(WeatherLoading());
    try{
      final weather = await weatherRepository.getWeather(city);
      emit(WeatherLoaded(weather));

    }catch(e){
      emit(WeatherError(e.toString()));
    }
  }
}
