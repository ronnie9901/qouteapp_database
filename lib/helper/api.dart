
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static ApiHelper apiServices = ApiHelper._();
  ApiHelper._();
  Future<List> fatchData() async {
    String api = 'https://sheetdb.io/api/v1/7zk7a4do030g9';

    Uri url = Uri.parse(api);

    Response response = await http.get(url);

    if (response.statusCode == 200) {
      final json = response.body;
      final List data = jsonDecode(json);
      print(data);
      return data;
    }
    else {
      return [];
    }
  }
}

