class WeeklyModel {
  String? day, date, temp;

  WeeklyModel({
    this.day,
    this.date,
    this.temp,
  });

  WeeklyModel.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    date = json['date'];
    temp = json['temp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['temp'] = temp;
    data['temp'] = temp;

    return data;
  }
}
