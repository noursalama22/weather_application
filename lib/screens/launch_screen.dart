import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_application/constants.dart';
import 'package:weather_application/model/current_weather_data.dart';
import 'package:weather_application/screens/weather_screen.dart';
import 'package:weather_application/service/current_weather.dart';
import 'package:weather_application/service/location.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  void getCurrentLocation() async {
    CurrentWeatherData currentWeatherData =
        await WeatherService().getCurrentWeatherData();
    if (mounted)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WeatherScreen(
              currentWeatherData: currentWeatherData,
            );
          },
        ),
      );
    // print("**************${locationService.long}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/global-warming.gif',width: 200,height: 200,),
            SizedBox(height: 12),
            Text(
              'Weather App',
              style: GoogleFonts.poppins(
                fontSize: 28,
                color: Colors.black54,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12),
            Text("Get Location....",style: dataStyle,),
          ],
        ),
      ),
    );
  }
}
