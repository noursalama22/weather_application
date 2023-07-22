import 'dart:convert';

import 'package:http/http.dart' as http;
// رجوع لقصة النو داتا
class ApiRepository {
  late String url;
  // final Map<String, dynamic> payload;

  ApiRepository({required this.url});

  Future<dynamic> get() async {
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return Future.error("No Data!");
    }
  }
}
