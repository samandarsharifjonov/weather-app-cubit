import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_weather_state.dart';

class SettingsWeatherCubit extends Cubit<SettingsWeatherState> {
  SettingsWeatherCubit() : super(const SettingsWeatherState(tempUnit: TempUnits.celsius));

  void toggleTemperature(){
    if(state.tempUnit == TempUnits.celsius){
      emit(const SettingsWeatherState(tempUnit: TempUnits.fahrenheit));
    }else{
      emit(const SettingsWeatherState(tempUnit: TempUnits.celsius));
    }
  }

}


