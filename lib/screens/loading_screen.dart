import 'package:climaapp/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/weather.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async{

    Duration duration = Duration(seconds: 3);
    await Future.delayed(duration);

    var weatherData = await WeatherModel().getLocationWeather();

    if(weatherData == null){
      AlertDialog(
        title: Text('An Error Occurred'),
        content: Text('A network problem occurred. Please hit retry or try after sometime'),
        actions: <Widget>[
          FlatButton(
            child: Text('Retry'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
      return;
    }

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => LocationScreen(locationWeather: weatherData,),
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
