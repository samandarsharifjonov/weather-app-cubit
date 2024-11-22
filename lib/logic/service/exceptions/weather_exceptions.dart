
class WeatherExceptions implements Exception{
  final String errorMessage;
  WeatherExceptions(this.errorMessage);
  @override
  String toString() {
    return errorMessage;
  }
}