import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/models/weekly_model.dart';

import 'home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<WeatherModel>(WeatherModelAdapter());
  Hive.registerAdapter<WeeklyModel>(WeeklyModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
