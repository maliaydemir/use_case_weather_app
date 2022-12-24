import 'package:flutter/material.dart';
import 'package:use_case_weather_app/Core/Extensions.dart';
import 'package:use_case_weather_app/Widgets/LoadingWidget.dart';

import '../Models/WeatherDataDTO.dart';

class WeatherDataWidget extends StatelessWidget {
  final WeatherDataDTO data;

  const WeatherDataWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: context.width,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              data.icon,
              height: 100,
              width: 100,
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(data.parsedDate.toFormat('dd MMMM yyyy, EEEE')),
              Text(data.description.capitalize()),
              Text('Derece:${data.degree}° (${data.min}° - ${data.max}°)'),
              Text('Nem: %${data.humidity}')
            ],
          ))
        ],
      ),
    );
  }
}
