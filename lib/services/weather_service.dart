import 'dart:convert';
import 'package:weather_app/model/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<Weather> getWeatherData(String place) async {
    //6870a5c95c3142feaa6172935232005
    //3wonegjycu1lg51vd20ilv00odekw08k4r12zhii

    final queryParm = {'key': '6870a5c95c3142feaa6172935232005', 'q': place};
    final parm = {
      'place_places': place,
      'sections': 'all',
      'timezone': 'UTC',
      'language': 'en',
      'units': 'metric',
      'key': '3wonegjycu1lg51vd20ilv00odekw08k4r12zhii'
    };
    if (place == null) {
      place = "london";
    }

    //https: //www.meteosource.com/api/v1/free/point?place_id=london&sections=all&timezone=UTC&language=en&units=metric&key=YOUR-API-KEY
//final uri = Uri.http('meteosource.com', '/api/v1/free/point?', parm);
    final uri = Uri.parse(
        'https://www.meteosource.com/api/v1/free/point?place_id=${place}&sections=all&timezone=auto&language=en&units=metric&key=3wonegjycu1lg51vd20ilv00odekw08k4r12zhii');
    print(place);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("can not get weather");
    }
  }
}
