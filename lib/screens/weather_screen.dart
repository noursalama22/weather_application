import 'dart:math';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_application/constants.dart';
import 'package:weather_application/model/current_weather_data.dart';
import 'package:weather_application/model/five_days_data.dart';
import 'package:weather_application/service/current_weather.dart';
import 'package:weather_application/service/five_day_three_hours_data.dart';
import 'package:weather_application/service/location.dart';
import 'package:intl/intl.dart';
import 'package:country_picker/country_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({Key? key, required this.currentWeatherData}) : super(key: key);
  CurrentWeatherData currentWeatherData;
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  void refreshWeatherData() {
    setState(() {
      // if (widget.currentWeatherData.name != null) {
      //   temp = widget.weatherData.temp!.toInt();
      // } else {
      //   temp = 0;
      // }
      // cityName = widget.weatherData.name;
      // icon = widget.weatherData.getWeatherIcon();
      // description = widget.weatherData.getMessage();
    });
  }

  late Future<List<FiveDayData>> _future;
  @override
  void initState() {
    super.initState();
    getFiveDayData();
  }

  getFiveDayData() {
    _future = FiveDayThreeHoursWeatherData()
        .get_FiveDayThreeHoursWeatherData(widget.currentWeatherData.name);
  }

  getCityWeather() async {
    widget.currentWeatherData =
        await WeatherService().getCityWeatherData(cityValue);
    setState(() {
      cityValue = widget.currentWeatherData.name;
    });
    getFiveDayData();
  }

  void getCurrentLocation() async {
    widget.currentWeatherData = await WeatherService().getCurrentWeatherData();
    setState(() {
      cityValue = widget.currentWeatherData.name;
    });
    getFiveDayData();
    // print("**************${locationService.long}");
  }

  bool isSearch = false;
  late String city;
  String countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackground,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(0, 6, 5, 5),
        leading: IconButton(
          onPressed: () async => getCurrentLocation(),
          icon: const Icon(
            Icons.refresh_rounded,
            size: 32,
            color: kblack,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    size: 32,
                    color: kblack,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "${widget.currentWeatherData.name}",
                      style: GoogleFonts.montserrat(
                        color: kblack,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 8.0),
            child: IconButton(
              color: kblack,
              icon: const Icon(
                Icons.search,
                size: 32,
              ),
              onPressed: () {
                setState(() {
                  isSearch = true;
                });

                // showCountryPicker(
                //   context: context,
                //   countryListTheme: CountryListThemeData(
                //     flagSize: 25,
                //     backgroundColor: Colors.white,
                //     textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                //     bottomSheetHeight:
                //         500, // Optional. Country list modal height
                //     //Optional. Sets the border radius for the bottomsheet.
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(20.0),
                //       topRight: Radius.circular(20.0),
                //     ),
                //     //Optional. Styles the search field.
                //     inputDecoration: InputDecoration(
                //       labelText: 'Search',
                //       hintText: 'Start typing to search',
                //       prefixIcon: const Icon(Icons.search),
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: const Color(0xFF8C98A8).withOpacity(0.2),
                //         ),
                //       ),
                //     ),
                //   ),
                //   onSelect: (value) {},
                // );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(bottom: 20),
        child: Column(
          children: [
            Visibility(
              visible: isSearch,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: CSCPicker(
                      showStates: true,
                      showCities: true,
                      flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value;
                          // isSearch = false;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(12),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() async {
                        isSearch = false;
                        await getCityWeather();
                      });
                    },
                    child: Text(
                      'Get Location!',
                      style: infoStyle,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !isSearch,
              child: Expanded(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(
                          '${widget.currentWeatherData.getWeatherIcon(widget.currentWeatherData.weather![0].id ?? 900)}'),
                    ),
                    Text(
                      "${widget.currentWeatherData.weather![0].description!.toUpperCase()},  ${widget.currentWeatherData.getMessage(widget.currentWeatherData.main!.temp!.toInt())} " ??
                          'Loading',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.currentWeatherData.main!.temp!
                                  .toInt()
                                  .toString() ??
                              'Loading',
                          style: GoogleFonts.poppins(
                            fontSize: 80,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          '\u00B0',
                          style: TextStyle(fontSize: 70),
                        ),
                      ],
                    ),
                    Text(
                      DateFormat('EEEE, d MMM yyyy | HH:mm')
                          .format(DateTime.now()),
                      //  DateFormat('EEEE, d MMM yyyy | HH:MM').format(
                      //           DateTime.parse(
                      //               widget.currentWeatherData.dt!.toString())) ??
                      //   DateFormat('EEEE, d MMM yyyy | HH:MM').format(DateTime.now())  ,
                      //  '${widget.currentWeatherData.dt}'
                      // 'Friday, 26 August 2022 | 10:00',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(31, 105, 103, 103),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.device_thermostat_sharp,
                                size: 32,
                                color: Colors.red[400],
                              ),
                              Text(
                                  '${widget.currentWeatherData.main!.tempMin!.toStringAsFixed(1)}\u00B0 - ${widget.currentWeatherData.main!.tempMax!.toStringAsFixed(1)}\u00B0',
                                  style: dataStyle),
                              Text(
                                'Min - Max Tmp',
                                style: infoStyle,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                size: 32,
                                Icons.water_drop,
                                color: Colors.blue[500],
                              ),
                              Text(
                                  '${widget.currentWeatherData.main!.humidity!}%',
                                  style: dataStyle),
                              Text(
                                'Humidity',
                                style: infoStyle,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(
                                size: 32,
                                Icons.air,
                                color: Colors.brown,
                              ),
                              Text(
                                  '${widget.currentWeatherData.wind!.speed!.toStringAsFixed(1)}km/h',
                                  style: dataStyle),
                              Text(
                                'Wind Speed',
                                style: infoStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FutureBuilder<List<FiveDayData>>(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          //Image.asset('assets/images/loading.gif',fit: BoxFit.contain,width: 150,height: 150,)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              // padding: EdgeInsets.all(12),
                              // physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsetsDirectional.symmetric(
                                      horizontal: 5),
                                  padding: EdgeInsetsDirectional.all(16),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(31, 105, 103, 103),
                                    // borderRadius: ,
                                    border: Border.all(color: Colors.black38),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  // alignment: Alignment.center,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        snapshot.data![index].dateTime!,
                                        style: infoStyle,
                                      ),
                                      Image.network(
                                        'https://openweathermap.org/img/wn/${snapshot.data![index].icon}.png',
                                        fit: BoxFit.contain,
                                      ),
                                      Text(
                                        "${snapshot.data![index].temp.toString()}\u00B0",
                                        style: dataStyle,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.warning,
                                  size: 80,
                                ),
                                Text(
                                  'No Data',
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45,
                                    fontSize: 24,
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
