import 'dart:async';
import 'package:http/http.dart' as http;

final api_key = "c516c7a32d3e17fb0c194aebcce425e2";
final base_url = "http://api.openweathermap.org/data/2.5/";

///Class for endpoints to API

class Api {

  static Future getWeatherByCity(String city){
    var url = base_url + "weather?q="+ city + "&APPID="+api_key;
    return http.get(url);
  }
}