//https://api.openweathermap.org/data/2.5/weather?q=london&lang=ar&appid=e3169d5fadc07e3a5e0ea3540f845128
class ApiSettings {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/';
  static const String weatherUrl = '${_baseUrl}weather?';
  static const String forecastUrl = '${_baseUrl}forecast?';
  static const String cityWeather = 'q=';
  static const String appid = 'appid=$_apiKey';
  static const String _apiKey = 'e3169d5fadc07e3a5e0ea3540f845128';
}
