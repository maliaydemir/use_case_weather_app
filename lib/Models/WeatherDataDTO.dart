class WeatherDataDTO {
  late String date;
  late String day;
  late String icon;
  late String description;
  late String status;
  late String degree;
  late String min;
  late String max;
  late String night;
  late String humidity;
  late DateTime parsedDate;

  WeatherDataDTO(
      {required this.date,
        required this.day,
        required this.icon,
        required this.description,
        required this.status,
        required this.degree,
        required  this.min,
        required this.max,
        required this.night,
        required this.humidity,
        required this.parsedDate});

  WeatherDataDTO.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    icon = json['icon'];
    description = json['description'];
    status = json['status'];
    degree = json['degree'];
    min = json['min'];
    max = json['max'];
    night = json['night'];
    humidity = json['humidity'];
    parsedDate = DateTime.parse(json['parsedDate']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['day'] = day;
    data['icon'] = icon;
    data['description'] = description;
    data['status'] = status;
    data['degree'] = degree;
    data['min'] = min;
    data['max'] = max;
    data['night'] = night;
    data['humidity'] = humidity;
    data['parsedDate'] = parsedDate.toString();
    return data;
  }
}
