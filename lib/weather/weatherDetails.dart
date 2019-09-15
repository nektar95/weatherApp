
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/fetching/Api.dart';
import 'package:weather_app/weather/weatherInfo.dart';

class WeatherDetails extends StatefulWidget {
  @override _WeatherDetailsState createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails>{
  var isText = true;
  var text = "Wyszukiwarka pogody.";
  var city = "";
  WeatherInfo info;
  final _cityController = TextEditingController();

  _fetchData() async {
    final response =
    await Api.getWeatherByCity(city);
    if (response.statusCode == 200) {
      info = WeatherInfo.fromJson(json.decode(response.body));
        setState(() {
          isText = false;
        });
    } else {
      if(response.statusCode == 404) {
        setState(() {
          text = "Brak takiego miasta";
        });
      } else
      setState(() {
        text = "Coś poszło nie tak :/";
      });
    }
  }

  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _fetchData();
      }
    } on SocketException catch (_) {
      setState(() {
        text = "Brak dostępu do Internetu";
      });
    }
  }

   _serachClick()  {
    city = _cityController.text;
    isText = true;
    checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)
                  ),
                  child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _cityController,
                          decoration: InputDecoration(
                              labelText: 'Wpisz miasto'
                          ),
                        ),
                        new MaterialButton(
                          onPressed: _serachClick,
                          child: Text('SZUKAJ POGODY'),
                        )
                      ]),
                ),
                new Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)
                  ),


                  child: (
                      isText ? new Text(
                        text,
                        textAlign: TextAlign.start,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline,
                      )
                      :
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            new Text(
                              info.getTemperature(),
                              textAlign: TextAlign.start,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                            ),
                            new Text(
                              info.getPressure(),
                              textAlign: TextAlign.start,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                            ),
                            new Text(
                              info.getHumidity(),
                              textAlign: TextAlign.start,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                            ),
                            new Text(
                              info.getWindSpeed(),
                              textAlign: TextAlign.start,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                            ),
                            new Text(
                              info.getWind(),
                              textAlign: TextAlign.start,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                            )
                          ])
                  )
                ),
              ],
            )

        ),
    );
  }
}