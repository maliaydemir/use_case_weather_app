import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:use_case_weather_app/Providers/ActivityProvider.dart';
import 'package:use_case_weather_app/Providers/WeatherProvider.dart';
import 'package:use_case_weather_app/Screens/HomeScreen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  Intl.defaultLocale = 'tr_TR';
  Intl.systemLocale = 'tr_TR';
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WeatherProvider>(create: (_) => WeatherProvider()),
        ChangeNotifierProvider<ActivityProvider>(create: (_) => ActivityProvider()),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: HomeScreen(),
      ),
    );
  }
}

