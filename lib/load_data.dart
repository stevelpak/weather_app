import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:weather/models/weather_model.dart';

final List<WeatherModel> listweather = [];

Future<bool?> loadData() async {
  var model = WeatherModel();
  var response = await get(Uri.parse("https://obhavo.uz/ferghana"));

  if (response.statusCode == 200) {
    var document = parse(response.body);

    var tempDoc = document.getElementsByClassName("current-forecast")[0];
    var docDetails = document
        .getElementsByClassName("current-forecast-details")[0]
        .querySelectorAll('p');

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

    listweather.add(model);
    return true;
  } else {
    return false;
  }
}
