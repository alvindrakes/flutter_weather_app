import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http; // this improves code readability!
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location location = Location();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location
        .getLocation(); // when you await for something, it has to be a 'Future'
    print(location.latitude);
    print(location.longitude);
  }

  void getData() async {
    http.Response response = await http.get(
        'http://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');

    // if status code is alright, only then store the results in a string variable
    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);

      int conditionNumber = decodedData['weather'][0]['id'];
      double temperature = decodedData['main']['temp'];
      String cityName = decodedData['name'];

      print(conditionNumber);
      print(temperature);
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Get the current location
//            getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
