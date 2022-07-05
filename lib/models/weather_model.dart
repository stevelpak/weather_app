class WeatherModel {
  String? temp, rain, wind, pess, moon, sun, sunset, tempNight, curDay, desc;
  List? weeklyForecast;

  WeatherModel({
    this.temp,
    this.rain,
    this.wind,
    this.pess,
    this.moon,
    this.sun,
    this.sunset,
    this.tempNight,
    this.curDay,
    this.desc,
    this.weeklyForecast,
  });

  WeatherModel.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    rain = json['rain'];
    wind = json['wind'];
    pess = json['pess'];
    moon = json['moon'];
    sun = json['sun'];
    sunset = json['sunset'];
    tempNight = json['tempNight'];
    curDay = json['curDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['temp'] = temp;
    data['rain'] = rain;
    data['wind'] = wind;
    data['pess'] = pess;
    data['moon'] = moon;
    data['sun'] = sun;
    data['sunset'] = sunset;
    data['tempNight'] = tempNight;
    data['curDay'] = curDay;

    return data;
  }
}
