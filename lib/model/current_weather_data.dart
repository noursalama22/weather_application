import '/model/clouds.dart';
import '/model/coord.dart';
import '/model/main_weather.dart';
import '/model/sys.dart';
import '/model/weather.dart';
import '/model/wind.dart';

class CurrentWeatherData {
  final Coord? coord;
  final List<Weather>? weather;
  final String? base;
  final MainWeather? main;
  final int? visibility;
  final Wind? wind;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  CurrentWeatherData(
      {this.coord,
      this.weather,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.dt,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod});

  factory CurrentWeatherData.fromJson(dynamic json) {
    if (json == null) {
      return CurrentWeatherData();
    }

    return CurrentWeatherData(
      coord: Coord.fromJson(json['coord']),
      weather:
          (json['weather'] as List).map((w) => Weather.fromJson(w)).toList(),
      base: json['base'],
      main: MainWeather.fromJson(json['main']),
      visibility: json['visibility'],
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
      sys: Sys.fromJson(json['sys']),
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
  String getWeatherIcon(int weatherId) {
    if (weatherId < 500) {
      return 'assets/images/drizzle.png';
    } else if (weatherId < 600) {
      return 'assets/images/rain.png';
    } else if (weatherId < 700) {
      return 'assets/images/snow.png';
    } else if (weatherId < 800) {
      return 'assets/images/mist.png';
    } else if (weatherId == 800) {
      return 'assets/images/clear.png';
    } else if (weatherId < 900) {
      return 'assets/images/clouds.png';
    } else {
      return 'assets/images/unKnown.png';
    }
  }
   String getMessage(int temp) {
      
      if (temp > 25) {
        return 'It\'s 🍦 time';
      } else if (temp > 20) {
        return 'Time for shorts and 👕';
      } else if (temp < 10) {
        return 'You\'ll need 🧣 and 🧤';
      } else {
        return 'Bring a 🧥 just in case';
      }
 
  }
}
