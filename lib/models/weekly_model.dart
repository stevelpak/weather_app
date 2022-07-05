class WeeklyModel {
  String? day, date, temp, desc;

  WeeklyModel({
    this.day,
    this.date,
    this.temp,
    this.desc,
  });

  WeeklyModel.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    date = json['date'];
    temp = json['temp'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['temp'] = temp;
    data['temp'] = temp;
    data['desc'] = desc;

    return data;
  }
}
