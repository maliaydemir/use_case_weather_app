import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:use_case_weather_app/Core/Extensions.dart';
import 'package:use_case_weather_app/Providers/ActivityProvider.dart';
import 'package:use_case_weather_app/Providers/WeatherProvider.dart';
import 'package:use_case_weather_app/Screens/UpdateActivityScreen.dart';
import 'package:use_case_weather_app/Widgets/LoadingWidget.dart';

import '../Widgets/WeatherDataWidget.dart';
import 'AddActivityScreen.dart';
import 'AllWeatherDatasScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Use Case App'),
      ),
      body: Column(
        children: [
          Consumer<WeatherProvider>(builder: (context, provider, child) {
            if (provider.todayWeatherDataLoading) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: LoadingWidget(),
              );
            } else if (provider.todayWeatherData != null) {
              return Stack(
                children: [
                  WeatherDataWidget(
                    data: provider.todayWeatherData!,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const AllWeatherDatasScreen()));
                      },
                      child: const Text('Show All'),
                    ),
                  )
                ],
              );
            } else {
              return Container();
            }
          }),
          Consumer<ActivityProvider>(builder: (context, provider, child) {
            return Expanded(
              child: Column(
                children: [
                  Container(
                    color: Colors.grey.shade400,
                    child: Row(
                      children: [
                        const Expanded(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Activities',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  provider.getActivities();
                                },
                                icon: const Icon(Icons.refresh_rounded)),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (_) =>
                                              const AddActivityScreen()))
                                      .then((value) {
                                    if (value == true) {
                                      provider.getActivities();
                                    }
                                  });
                                },
                                icon: const Icon(Icons.add_rounded)),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: provider.activitiesLoading
                        ? const Center(
                            child: LoadingWidget(),
                          )
                        : ListView.builder(
                            itemCount: provider.activities.length,
                            itemBuilder: (context, i) {
                              var activity = provider.activities[0];
                              return Card(
                                child: ExpansionTile(
                                  title: Text(activity.title ?? '-'),
                                  subtitle: Text(activity.date
                                          ?.toFormat('dd MMMM yyyy hh:mm') ??
                                      '-'),
                                  expandedCrossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text('Id: ${activity.id}'),
                                    Text('Title: ${activity.title ?? '-'}'),
                                    Text(
                                        'Description:${activity.description ?? '-'}'),
                                    Text('City: ${activity.city ?? '_'}'),
                                    Text(
                                        'Category: ${activity.category ?? '-'}'),
                                    Text('Venue: ${activity.venue ?? '-'}'),
                                    Text(
                                        'Date: ${activity.date?.toFormat('dd MMMM yyyy hh:mm') ?? '-'}'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        MaterialButton(
                                          onPressed: () async {
                                            await provider
                                                .deleteActivity(activity.id!);
                                            provider.getActivities();
                                          },
                                          shape: const StadiumBorder(),
                                          color: Colors.red,
                                          child: const Text(
                                            'Delete',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (_) =>
                                                        UpdateActivityScreen(
                                                            activity:
                                                                activity)))
                                                .then((value) {
                                              if (value == true) {
                                                provider.getActivities();
                                              }
                                            });
                                          },
                                          shape: const StadiumBorder(),
                                          color: Colors.blue,
                                          child: const Text(
                                            'Update',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<WeatherProvider>().getTodayWeatherData();
      context.read<ActivityProvider>().getActivities();
    });
    super.initState();
  }
}
