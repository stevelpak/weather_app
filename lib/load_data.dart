import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:weather/models/weather_model.dart';

String? temp, rain, wind, pess, moon, sun, sunset, day1;

void main(List<String> args) async {
  await Weather().loadData();
}

class Weather {
  Future loadData() async {
    var response = await get(Uri.parse("https://obhavo.uz/ferghana"));

    if (response.statusCode == 200) {
      var document = parse(response.body);

      var docDetails = document
          .getElementsByClassName("current-forecast-details")[0]
          .querySelectorAll('p');
      day1 = document
          .getElementsByClassName("weather-row-forecast")[0]
          .querySelectorAll('span')[0]
          .text;

      temp = document
          .getElementsByClassName("current-forecast-day")[0]
          .querySelectorAll('p')[5]
          .text;
      rain = docDetails[0].text.substring(8);
      wind = docDetails[1].text.substring(8);
      pess = docDetails[2].text.substring(7);
      moon = docDetails[3].text.substring(4);
      sun = docDetails[4].text.substring(17);
      sunset = docDetails[5].text.substring(16);
    }
  }

  String? exportData() {
    return day1;
  }
}
