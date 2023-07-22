import 'dart:convert';

import 'package:weather_application/api/api_repository.dart';
import 'package:weather_application/api/api_settings.dart';
import 'package:weather_application/model/current_weather_data.dart';
import 'package:weather_application/service/location.dart';

class WeatherService {
  Future<dynamic> getCurrentWeatherData() async {
    LocationService locationService = LocationService();
    await locationService.getCurrentLocation();
    var response = await ApiRepository(
            url:
                '${ApiSettings.weatherUrl}lat=${locationService.lat}&lon=${locationService.long}&${ApiSettings.appid}&units=metric')
        .get();
    CurrentWeatherData currentWeatherData =
        CurrentWeatherData.fromJson(response);
    return currentWeatherData;
  }

  getCityWeatherData(String? city) async {
    if (city != null) {
      var response = await ApiRepository(
              url:
                  '${ApiSettings.weatherUrl}${ApiSettings.cityWeather}$city&${ApiSettings.appid}&units=metric')
          .get();
      CurrentWeatherData currentWeatherData =
          CurrentWeatherData.fromJson(response);
      return currentWeatherData;
    } 
  }

  getFiveDayThreeHourData(String? city) async {
    if (city != null) {
      var response = await ApiRepository(
              url:
                  '${ApiSettings.weatherUrl}${ApiSettings.cityWeather}$city&${ApiSettings.appid}&units=metric')
          .get();
      CurrentWeatherData currentWeatherData =
          CurrentWeatherData.fromJson(response);
      return currentWeatherData;
    }
  }

}
