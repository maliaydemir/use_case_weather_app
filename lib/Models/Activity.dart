import 'package:use_case_weather_app/Core/Extensions.dart';

class Activity {
  String? id;
  String? title;
  DateTime? date;
  String? description;
  String? category;
  String? city;
  String? venue;

  Activity(
      {this.id,
      this.title,
      this.date,
      this.description,
      this.category,
      this.city,
      this.venue});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = DateTime.parse(json['date']);
    description = json['description'];
    category = json['category'];
    city = json['city'];
    venue = json['venue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    data['title'] = title;
    if (date != null) data['date'] = date!.toFormat('yyyy-MM-ddThh:mm:ss');
    data['description'] = description;
    data['category'] = category;
    data['city'] = city;
    data['venue'] = venue;
    return data;
  }
}
