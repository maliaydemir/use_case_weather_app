import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:use_case_weather_app/Models/Activity.dart';

import '../Core/HttpBase.dart';

class ActivityProvider with ChangeNotifier {
  List<Activity> activities = [];
  bool activitiesLoading = false;

  getActivities() async {
    activitiesLoading = true;
    notifyListeners();
    var response = await HttpBase.instance.get('/api/Activity');
    if (response.statusCode == 200) {
      Iterable itr = jsonDecode(response.body)['result'];
      activities = itr.map((e) => Activity.fromJson(e)).toList();
    } else {
      activities = [];
    }
    activitiesLoading = false;
    notifyListeners();
  }

  addActivity(Activity activity) async {
    var response = await HttpBase.instance
        .post('/api/Activity', bodyData: activity.toJson());
  }

  updateActivity(Activity activity) async {
    var response = await HttpBase.instance
        .put('/api/Activity', bodyData: activity.toJson());
  }

  deleteActivity(String id) async {
    await HttpBase.instance.delete('/api/Activity/$id');
  }
}
