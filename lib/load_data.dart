import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/models/weekly_model.dart';

final List<WeatherModel> listweather = [];
final List<WeeklyModel> listweekly = [];

Future<bool?> loadData(String city) async {
  var model = WeatherModel();
  var response =
      await get(Uri.parse("https://obhavo.uz/${city.toLowerCase()}"));

  if (response.statusCode == 200) {
    var document = parse(response.body);

    var tempDoc = document.getElementsByClassName("current-forecast")[0];
    var docDetails = document
        .getElementsByClassName("current-forecast-details")[0]
        .querySelectorAll('p');
    var wkDoc = document.getElementsByClassName("weather-row-day-short");
    var wkTemp = document.getElementsByClassName('weather-row-forecast');

    model.temp = tempDoc.querySelectorAll('strong')[0].text.substring(1);
    model.rain = docDetails[0].text.substring(8);
    model.wind = docDetails[1].text.substring(8);
    model.pess = docDetails[2].text.substring(7, 11);
    model.moon = docDetails[3].text.substring(4);
    model.sun = docDetails[4].text.substring(17);
    model.sunset = docDetails[5].text.substring(16);
    model.tempNight = tempDoc.querySelectorAll('span')[2].text.substring(1);
    model.curDay = document
        .getElementsByClassName("current-day")[0]
        .text
        .toString()
        .substring(6);
    model.desc =
        document.getElementsByClassName("current-forecast-desc")[0].text;

    for (var i = 0; i < 7; i++) {
      var wkModel = WeeklyModel();
      wkModel.day = wkDoc[i + 1].querySelectorAll('strong')[0].text;
      wkModel.date = wkDoc[i + 1].querySelectorAll('div')[0].text;
      wkModel.temp = wkTemp[i].querySelectorAll('span')[0].text;
      wkModel.desc = document
          .getElementsByClassName('weather-row-desc')[i + 1]
          .text
          .trim();
      listweekly.add(wkModel);
    }

    listweather.add(model);
    return true;
  } else {
    return false;
  }
}
