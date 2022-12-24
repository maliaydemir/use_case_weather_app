import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:use_case_weather_app/Core/HttpBase.dart';

import '../Models/WeatherDataDTO.dart';

class WeatherProvider with ChangeNotifier {
  List<WeatherDataDTO> weatherDatas = [];
  bool weatherDatasLoading = false;
  WeatherDataDTO? todayWeatherData;
  bool todayWeatherDataLoading = false;

  getWeatherDatas() async {
    weatherDatasLoading = true;
    notifyListeners();
    var response = await HttpBase.instance.get('/api/Weather');
    if (response.statusCode == 200) {
      Iterable itr = jsonDecode(response.body)['result'];
      weatherDatas = itr.map((e) => WeatherDataDTO.fromJson(e)).toList();
    } else {
      weatherDatas = [];
    }
    weatherDatasLoading = false;
    notifyListeners();
  }

  getTodayWeatherData() async {
    todayWeatherDataLoading = true;
    notifyListeners();
    var response = await HttpBase.instance.get('/api/Weather/Today');
    print(response.statusCode);
    if (response.statusCode == 200) {
      todayWeatherData = WeatherDataDTO.fromJson(jsonDecode(response.body)['result']);
    } else {
      todayWeatherData = null;
    }
    todayWeatherDataLoading = false;
    notifyListeners();
  }
}
