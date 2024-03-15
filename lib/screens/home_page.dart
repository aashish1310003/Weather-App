import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:weather_app/function.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/services/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherService weatherService = WeatherService();
  Weather weather = Weather();
  String url = '';
  String output = "default";
  var data;
  double temp = 0;
  double cond = 0;
  String date = '';
  String city = '';
  String status = '';
  TextEditingController _cityController = TextEditingController();
  String apiData = '';
  Map<String, dynamic> j = const {};

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print("hi");
    super.initState();
    getWeather("erode");
  }

  void getWeather(String cityName) async {
    weather = await weatherService.getWeatherData(cityName);
    city = cityName;
    temp = (weather.temperature_c);
    cond = (weather.condition);
    date = (weather.date);
    status = weather.status;
    j = weather.j;

    //print(weather.temperature_min);
    print(temp);
    print(date);
    print(weather.condition);
  }

  Widget build(BuildContext context) {
    String cityName = city; //city name
    double currTemp = temp; // current temperature
    int maxTemp = temp.toInt() + 5; // today max temperature
    int minTemp = temp.toInt() - 5; // today min temperature
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black : Colors.white,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.width * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.bars,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            Align(
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Weather App',
                                      style: GoogleFonts.questrial(
                                        color: isDarkMode
                                            ? Colors.white
                                            : const Color(0xff1D1617),
                                        fontSize: size.height * 0.02,
                                      ),
                                    ),
                                    Container(
                                      // Wrap the TextField with a Container
                                      width:
                                          100, // Provide a specific width constraint
                                      child: TextField(
                                        controller: _cityController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter city name',
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        String cityName = _cityController.text;
                                        getWeather(cityName);
                                      },
                                      child: Text('Get Data'),
                                    ),
                                    // SizedBox(
                                    //   width:
                                    //       200, // Set a finite width for the TextField
                                    //   child: TextField(
                                    //     onChanged: (value) {
                                    //       url = 'http://10.0.2.2:5000/?query=' +
                                    //           value.toString();
                                    //     },
                                    //   ),
                                    // ),
                                    // TextButton(
                                    //   onPressed: () async {
                                    //     Map<String, dynamic> jsonData =
                                    //         await jsonDecode(fetchdata(url));
                                    //     data = await fetchdata(url);
                                    //     setState(() {
                                    //       output = data['dir']["hourly"]["data"]
                                    //       [0]["temperature"];
                                    //     });
                                    //   },
                                    //   child: Text("Location"),
                                    // ),
                                    //Text(output)
                                  ],
                                ),
                              ),
                            ),
                            FaIcon(
                              FontAwesomeIcons.plusCircle,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.03,
                        ),
                        child: Align(
                          child: Text(
                            cityName,
                            style: GoogleFonts.questrial(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: size.height * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.005,
                        ),
                        child: Align(
                          child: Text(
                            'Today', //day
                            style: GoogleFonts.questrial(
                              color:
                                  isDarkMode ? Colors.white54 : Colors.black54,
                              fontSize: size.height * 0.035,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.03,
                        ),
                        child: Align(
                          child: Text(
                            '$currTemp˚C', //curent temperature
                            style: GoogleFonts.questrial(
                              color: currTemp <= 0
                                  ? Colors.blue
                                  : currTemp > 0 && currTemp <= 15
                                      ? Colors.indigo
                                      : currTemp > 15 && currTemp < 30
                                          ? Colors.deepPurple
                                          : Colors.pink,
                              fontSize: size.height * 0.13,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.25),
                        child: Divider(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.005,
                        ),
                        child: Align(
                          child: Text(
                            status, // weather
                            style: GoogleFonts.questrial(
                              color:
                                  isDarkMode ? Colors.white54 : Colors.black54,
                              fontSize: size.height * 0.03,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.03,
                          bottom: size.height * 0.01,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$minTemp˚C', // min temperature
                              style: GoogleFonts.questrial(
                                color: minTemp <= 0
                                    ? Colors.blue
                                    : minTemp > 0 && minTemp <= 15
                                        ? Colors.indigo
                                        : minTemp > 15 && minTemp < 30
                                            ? Colors.deepPurple
                                            : Colors.pink,
                                fontSize: size.height * 0.03,
                              ),
                            ),
                            Text(
                              '/',
                              style: GoogleFonts.questrial(
                                color: isDarkMode
                                    ? Colors.white54
                                    : Colors.black54,
                                fontSize: size.height * 0.03,
                              ),
                            ),
                            Text(
                              '$maxTemp˚C', //max temperature
                              style: GoogleFonts.questrial(
                                color: maxTemp <= 0
                                    ? Colors.blue
                                    : maxTemp > 0 && maxTemp <= 15
                                        ? Colors.indigo
                                        : maxTemp > 15 && maxTemp < 30
                                            ? Colors.deepPurple
                                            : Colors.pink,
                                fontSize: size.height * 0.03,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.05)
                                : Colors.black.withOpacity(0.05),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.01,
                                    left: size.width * 0.03,
                                  ),
                                  child: Text(
                                    'Forecast for today',
                                    style: GoogleFonts.questrial(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: size.height * 0.025,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(size.width * 0.005),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      //TODO: change weather forecast from local to api get
                                      date == null
                                          ? CircularProgressIndicator()
                                          : buildForecastToday(
                                              !j.isEmpty
                                                  ? j["hourly"]["data"][0]
                                                          ["date"]
                                                      .substring(11, 16)
                                                  : "null", //hour
                                              !j.isEmpty
                                                  ? j["hourly"]["data"][0]
                                                      ["temperature"]
                                                  : 0, //temperature getTemperatureFromJson(jsonString)
                                              !j.isEmpty
                                                  ? j["hourly"]["data"][0]
                                                      ["wind"]["speed"]
                                                  : 0, //wind (km/h)getTemperatureFromJson(jsonString)
                                              !j.isEmpty
                                                  ? j["hourly"]["data"][0]
                                                      ["precipitation"]["total"]
                                                  : 0, //rain chance (%)getRainFromJson(jsonString)
                                              FontAwesomeIcons
                                                  .sun, //weather icon
                                              size,
                                              isDarkMode,
                                            ),
                                      buildForecastToday(
                                        !j.isEmpty
                                            ? j["hourly"]["data"][1]["date"]
                                                .substring(11, 16)
                                            : "null", //hour
                                        !j.isEmpty
                                            ? j["hourly"]["data"][1]
                                                ["temperature"]
                                            : 0, //temperature getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][1]["wind"]
                                                ["speed"]
                                            : 0, //wind (km/h)getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][1]
                                                ["precipitation"]["total"]
                                            : 0, //rain chance (%)getRainFromJson(jsonString)
                                        FontAwesomeIcons.cloud,
                                        size,
                                        isDarkMode,
                                      ),
                                      buildForecastToday(
                                        !j.isEmpty
                                            ? j["hourly"]["data"][2]["date"]
                                                .substring(11, 16)
                                            : "null", //hour
                                        !j.isEmpty
                                            ? j["hourly"]["data"][2]
                                                ["temperature"]
                                            : 0, //temperature getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][2]["wind"]
                                                ["speed"]
                                            : 0, //wind (km/h)getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][2]
                                                ["precipitation"]["total"]
                                            : 0, //rain chance (%)getRainFromJson(jsonString)
                                        FontAwesomeIcons.cloudRain,
                                        size,
                                        isDarkMode,
                                      ),
                                      buildForecastToday(
                                        !j.isEmpty
                                            ? j["hourly"]["data"][3]["date"]
                                                .substring(11, 16)
                                            : "null", //hour
                                        !j.isEmpty
                                            ? j["hourly"]["data"][3]
                                                ["temperature"]
                                            : 0, //temperature getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][3]["wind"]
                                                ["speed"]
                                            : 0, //wind (km/h)getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][3]
                                                ["precipitation"]["total"]
                                            : 0, //rain chance (%)getRainFromJson(jsonString)
                                        FontAwesomeIcons.snowflake,
                                        size,
                                        isDarkMode,
                                      ),
                                      buildForecastToday(
                                        !j.isEmpty
                                            ? j["hourly"]["data"][4]["date"]
                                                .substring(11, 16)
                                            : "null", //hour
                                        !j.isEmpty
                                            ? j["hourly"]["data"][4]
                                                ["temperature"]
                                            : 0, //temperature getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][4]["wind"]
                                                ["speed"]
                                            : 0, //wind (km/h)getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][4]
                                                ["precipitation"]["total"]
                                            : 0, //rain chance (%)getRainFromJson(jsonString)
                                        FontAwesomeIcons.cloudMoon,
                                        size,
                                        isDarkMode,
                                      ),
                                      buildForecastToday(
                                        !j.isEmpty
                                            ? j["hourly"]["data"][5]["date"]
                                                .substring(11, 16)
                                            : "null", //hour
                                        !j.isEmpty
                                            ? j["hourly"]["data"][5]
                                                ["temperature"]
                                            : 0, //temperature getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][5]["wind"]
                                                ["speed"]
                                            : 0, //wind (km/h)getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][5]
                                                ["precipitation"]["total"]
                                            : 0, //rain chance (%)getRainFromJson(jsonString)
                                        FontAwesomeIcons.snowflake,
                                        size,
                                        isDarkMode,
                                      ),
                                      buildForecastToday(
                                        !j.isEmpty
                                            ? j["hourly"]["data"][6]["date"]
                                                .substring(11, 16)
                                            : "null", //hour
                                        !j.isEmpty
                                            ? j["hourly"]["data"][6]
                                                ["temperature"]
                                            : 0, //temperature getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][6]["wind"]
                                                ["speed"]
                                            : 0, //wind (km/h)getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][6]
                                                ["precipitation"]["total"]
                                            : 0, //rain chance (%)getRainFromJson(jsonString)
                                        FontAwesomeIcons.snowflake,
                                        size,
                                        isDarkMode,
                                      ),
                                      buildForecastToday(
                                        !j.isEmpty
                                            ? j["hourly"]["data"][7]["date"]
                                                .substring(11, 16)
                                            : "null", //hour
                                        !j.isEmpty
                                            ? j["hourly"]["data"][7]
                                                ["temperature"]
                                            : 0, //temperature getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][7]["wind"]
                                                ["speed"]
                                            : 0, //wind (km/h)getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][7]
                                                ["precipitation"]["total"]
                                            : 0, //rain chance (%)getRainFromJson(jsonString)
                                        FontAwesomeIcons.cloudMoon,
                                        size,
                                        isDarkMode,
                                      ),
                                      buildForecastToday(
                                        !j.isEmpty
                                            ? j["hourly"]["data"][8]["date"]
                                                .substring(11, 16)
                                            : "null", //hour
                                        !j.isEmpty
                                            ? j["hourly"]["data"][8]
                                                ["temperature"]
                                            : 0, //temperature getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][8]["wind"]
                                                ["speed"]
                                            : 0, //wind (km/h)getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][8]
                                                ["precipitation"]["total"]
                                            : 0, //rain chance (%)getRainFromJson(jsonString)
                                        FontAwesomeIcons.moon,
                                        size,
                                        isDarkMode,
                                      ),
                                      buildForecastToday(
                                        !j.isEmpty
                                            ? j["hourly"]["data"][9]["date"]
                                                .substring(11, 16)
                                            : "null", //hour
                                        !j.isEmpty
                                            ? j["hourly"]["data"][9]
                                                ["temperature"]
                                            : 0, //temperature getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][9]["wind"]
                                                ["speed"]
                                            : 0, //wind (km/h)getTemperatureFromJson(jsonString)
                                        !j.isEmpty
                                            ? j["hourly"]["data"][9]
                                                ["precipitation"]["total"]
                                            : 0, //rain chance (%)getRainFromJson(jsonString)
                                        FontAwesomeIcons.moon,
                                        size,
                                        isDarkMode,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: size.height * 0.02,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.white.withOpacity(0.05),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.02,
                                    left: size.width * 0.03,
                                  ),
                                  child: Text(
                                    '7-day forecast',
                                    style: GoogleFonts.questrial(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: size.height * 0.025,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                              Padding(
                                padding: EdgeInsets.all(size.width * 0.005),
                                child: Column(
                                  children: [
                                    //TODO: change weather forecast from local to api get
                                    buildSevenDayForecast(
                                      "Today", //day
                                      minTemp, //min temperature
                                      maxTemp, //max temperature
                                      FontAwesomeIcons.cloud, //weather icon
                                      size,
                                      isDarkMode,
                                    ),
                                    buildSevenDayForecast(
                                      "Wed",
                                      -5,
                                      5,
                                      FontAwesomeIcons.sun,
                                      size,
                                      isDarkMode,
                                    ),
                                    buildSevenDayForecast(
                                      "Thu",
                                      -2,
                                      7,
                                      FontAwesomeIcons.cloudRain,
                                      size,
                                      isDarkMode,
                                    ),
                                    buildSevenDayForecast(
                                      "Fri",
                                      3,
                                      10,
                                      FontAwesomeIcons.sun,
                                      size,
                                      isDarkMode,
                                    ),
                                    buildSevenDayForecast(
                                      "San",
                                      5,
                                      12,
                                      FontAwesomeIcons.sun,
                                      size,
                                      isDarkMode,
                                    ),
                                    buildSevenDayForecast(
                                      "Sun",
                                      4,
                                      7,
                                      FontAwesomeIcons.cloud,
                                      size,
                                      isDarkMode,
                                    ),
                                    buildSevenDayForecast(
                                      "Mon",
                                      -2,
                                      1,
                                      FontAwesomeIcons.snowflake,
                                      size,
                                      isDarkMode,
                                    ),
                                    buildSevenDayForecast(
                                      "Tues",
                                      0,
                                      3,
                                      FontAwesomeIcons.cloudRain,
                                      size,
                                      isDarkMode,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForecastToday(String time, double temp, double wind,
      double rainChance, IconData weatherIcon, size, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.025),
      child: Column(
        children: [
          Text(
            time,
            style: GoogleFonts.questrial(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: size.height * 0.02,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.005,
                ),
                child: FaIcon(
                  weatherIcon,
                  color: isDarkMode ? Colors.white : Colors.black,
                  size: size.height * 0.03,
                ),
              ),
            ],
          ),
          Text(
            '$temp˚C',
            style: GoogleFonts.questrial(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: size.height * 0.025,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                ),
                child: FaIcon(
                  FontAwesomeIcons.wind,
                  color: Colors.grey,
                  size: size.height * 0.03,
                ),
              ),
            ],
          ),
          Text(
            '$wind km/h',
            style: GoogleFonts.questrial(
              color: Colors.grey,
              fontSize: size.height * 0.02,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                ),
                child: FaIcon(
                  FontAwesomeIcons.umbrella,
                  color: Colors.blue,
                  size: size.height * 0.03,
                ),
              ),
            ],
          ),
          Text(
            '$rainChance %',
            style: GoogleFonts.questrial(
              color: Colors.blue,
              fontSize: size.height * 0.02,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSevenDayForecast(String time, int minTemp, int maxTemp,
      IconData weatherIcon, size, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.all(
        size.height * 0.005,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                ),
                child: Text(
                  time,
                  style: GoogleFonts.questrial(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: size.height * 0.025,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.25,
                ),
                child: FaIcon(
                  weatherIcon,
                  color: isDarkMode ? Colors.white : Colors.black,
                  size: size.height * 0.03,
                ),
              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.15,
                  ),
                  child: Text(
                    '$minTemp˚C',
                    style: GoogleFonts.questrial(
                      color: isDarkMode ? Colors.white38 : Colors.black38,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                  ),
                  child: Text(
                    '$maxTemp˚C',
                    style: GoogleFonts.questrial(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
}
