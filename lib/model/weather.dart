class Weather {
  final String date;
  final double temperature_c;
  final double temperature_min;
  final String status;
  final int icon;
  final double condition;
  final Map<String, dynamic> j;

  Weather({
    this.date = 'null',
    this.status = 'null',
    this.icon = 0,
    this.temperature_c = 0,
    this.temperature_min = 0,
    this.condition = 0,
    this.j = const {},
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        j: json,
        date: json["hourly"]["data"][0]["date"].substring(11, 16),
        temperature_c: json["current"]["temperature"],
        //temperature_min: json["hourly"]["data"][0]["feels_like"],
        condition: json["current"]["precipitation"]["total"],
        status: json["current"]["summary"]);
  }
}
