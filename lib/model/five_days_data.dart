class FiveDayData {
  final String? dateTime;
  final int? temp;
  final String? icon;

  FiveDayData({this.dateTime, this.temp, this.icon});
  factory FiveDayData.fromJson(dynamic json) {
    if (json == null) {
      return FiveDayData();
    }

    var f = json['dt_txt'].split(' ')[0].split('-')[2] +
        '/' +
        json['dt_txt'].split(' ')[0].split('-')[1];
    var l = json['dt_txt'].split(' ')[1].split(':')[0] +
        ':' +
        json['dt_txt'].split(' ')[1].split(':')[1];
    var fandl = '$f\n$l';
    return FiveDayData(
        dateTime: '$fandl',
        temp: (double.parse(json['main']['temp'].toString())).round(),
        icon: json['weather'][0]['icon']);
  }
}
