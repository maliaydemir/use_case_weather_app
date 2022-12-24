import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:use_case_weather_app/Providers/WeatherProvider.dart';
import 'package:use_case_weather_app/Widgets/LoadingWidget.dart';
import 'package:use_case_weather_app/Widgets/WeatherDataWidget.dart';

class AllWeatherDatasScreen extends StatefulWidget {
  const AllWeatherDatasScreen({Key? key}) : super(key: key);

  @override
  State<AllWeatherDatasScreen> createState() => _AllWeatherDatasScreenState();
}

class _AllWeatherDatasScreenState extends State<AllWeatherDatasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Weather Datas'),
      ),
      body: Consumer<WeatherProvider>(builder: (context, provider, child) {
        if(provider.weatherDatasLoading)
          return Center(
            child: LoadingWidget(),
          );

        return ListView.builder(
            itemCount: provider.weatherDatas.length,
            itemBuilder: (context, i) {
              return WeatherDataWidget(data: provider.weatherDatas[i]);
            });
      }),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<WeatherProvider>().getWeatherDatas();
    });
    super.initState();
  }
}
