import 'package:flutter_trip/model/home_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';
//首页大接口
class HomeDao {
  static Future<HomeModel> fetch() async {
    var url = Uri.parse(HOME_URL);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //fix 中文乱码
      Utf8Decoder utf8decoder = Utf8Decoder();
      final result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.formJson(result);
    } else {
      throw Exception('Fail to load home_page.json');
    }
  }
}
