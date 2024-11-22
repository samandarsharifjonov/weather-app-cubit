class Weather {
  final String id;
  final String main;
  final String description;
  final String icon;
  final double temp;
  final String city;
  final double wind;
  final double humidity;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.temp,
    required this.city,
    required this.wind,
    required this.humidity
  });
}
