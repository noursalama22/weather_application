import 'dart:convert';

import 'package:weather_application/api/api_repository.dart';
import 'package:weather_application/api/api_settings.dart';
import 'package:weather_application/model/five_days_data.dart';

class FiveDayThreeHoursWeatherData {
  Future<List<FiveDayData>> get_FiveDayThreeHoursWeatherData(
      String? city) async {
    List<FiveDayData> fiveDayData = [];
    print(
        '${ApiSettings.forecastUrl}q=$city&${ApiSettings.appid}&units=metric');
    var response = await ApiRepository(
            url:
                '${ApiSettings.forecastUrl}q=$city&${ApiSettings.appid}&units=metric')
        .get();

    response['list'].forEach((e) {
      print(e);
      fiveDayData.add(FiveDayData.fromJson(e));
    });
    print(response['list']);
    print(fiveDayData.length);
    // (response['list'] as List).map((t) => FiveDayData.fromJson(t)).toList();
    return fiveDayData;
  }
}
