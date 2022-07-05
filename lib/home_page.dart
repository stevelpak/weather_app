import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'package:weather/utils/constants.dart';
import 'package:weather/widgets/weekly.dart';
import 'package:weather/widgets/info_con.dart';
import 'package:weather/utils/hive_util.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/models/weekly_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HiveUtil {
  List<WeatherModel> listweather = [];
  List<WeeklyModel> listweekly = [];

  Future<bool?> loadData(String city) async {
    if (await loadLocalData()) {
      try {
        listweekly.clear();
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
          var wkRain = document.getElementsByClassName("weather-row-pop");

          model.temp = tempDoc.querySelectorAll('strong')[0].text.substring(1);
          model.rain = docDetails[0].text.substring(8);
          model.wind = docDetails[1].text.substring(8).split(",").last;
          model.pess = docDetails[2].text.substring(7, 11);
          model.moon = docDetails[3].text.substring(4);
          model.sun = docDetails[4].text.substring(17);
          model.sunset = docDetails[5].text.substring(16);
          model.tempNight =
              tempDoc.querySelectorAll('span')[2].text.substring(1);
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
            wkModel.rainPer = wkRain[i + 1].text.trim().split("%")[0];
            listweekly.add(wkModel);
          }
          listweather.add(model);

          await saveBox<String>(dateBox,
              DateFormat('dd.MM.yyyy').format(DateTime.now()).toString(),
              key: dateKey);
          await saveBox<List<WeatherModel>>(weatherBox, listweather,
              key: weatherListKey);
          await saveBox<List<WeeklyModel>>(weeklyBox, listweekly,
              key: weeklyListKey);

          return true;
        } else {
          _showMessage('Unknown error');
        }
      } on SocketException {
        _showMessage('Connection error');
      } catch (e) {
        _showMessage(e.toString());
      }
    }
    return null;
  }

  Future<bool> loadLocalData() async {
    try {
      var date = await getBox<String>(dateBox, key: dateKey);
      if (date ==
          DateFormat('dd.MM.yyyy')
              .format(DateTime.now().add(const Duration(days: -1)))) {
        listweather = await getBox(weatherBox, key: weatherListKey) ?? [];
        listweather = await getBox(weeklyBox, key: weatherListKey) ?? [];
        return false;
      } else {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }

    return true;
  }

  _showMessage(String text, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Colors.green[400],
        content: Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  var cities = [
    'Tashkent',
    'Andijan',
    'Bukhara',
    'Gulistan',
    'Jizzakh',
    'Zarafshan',
    'Karshi',
    'Navoi',
    'Namangan',
    'Nukus',
    'Samarkand',
    'Termez',
    'Urgench',
    'Ferghana',
    'Khiva',
  ];

  Map<String, String> wtypes = {
    "ochiq havo": "ic_sunny",
    "bulutli": "ic_mist",
    "yomg'ir": "ic_rain",
  };

  String dropDownValue = 'Tashkent';
  String _pressed = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: bgGradient,
            ),
            child: FutureBuilder(
              future: listweather.isEmpty ? loadData(dropDownValue) : null,
              builder: ((context, snapshot) {
                if (snapshot.hasData && listweather.isNotEmpty) {
                  if (_pressed.isEmpty) {
                    _pressed = listweekly.first.date!;
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (() {}),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(30),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/settings.png"),
                                  ),
                                  boxShadow: [topBoxShadow],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    menuMaxHeight: 300,
                                    value: dropDownValue,
                                    icon: const Visibility(
                                      visible: false,
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    items: cities.map(
                                      (String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            items,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: topCityColor),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (String? newValue) {
                                      setState(
                                        () {
                                          dropDownValue = newValue!;
                                          listweather.clear();
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    gradient: stateGradient,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Yangilandi°",
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: (() {}),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: white,
                                    width: 3,
                                  ),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/user.png"),
                                    fit: BoxFit.fill,
                                  ),
                                  boxShadow: [topBoxShadow],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Flexible(
                          child: ListView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 5),
                                margin: const EdgeInsets.only(top: 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(33),
                                  gradient: stateGradient,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(82, 100, 240, 0.31),
                                      offset: Offset(10, 15),
                                      blurRadius: 30,
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 120, left: 20),
                                          child: Text(
                                            listweather[0].desc!,
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Bugun\n${listweather[0].curDay}",
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          GradientText(
                                            listweather[0].temp!,
                                            gradient: textGradient,
                                            style: const TextStyle(
                                              fontSize: 60,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${listweather[0].desc} ${listweather[0].tempNight}",
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 15,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Image.asset(
                                  "assets/states/${wtypes[listweather[0].desc!.toLowerCase()]}.png",
                                  scale: 2,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(85, 85, 85, 0.05),
                                  offset: Offset(5, 15),
                                  blurRadius: 30,
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: Image.asset(
                                              "assets/info/water.png",
                                              scale: 4,
                                            ),
                                          ),
                                          const Text(
                                            "Havo sifati",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            listweather.clear();
                                          });
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: white,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.08),
                                                offset: Offset(0, 2),
                                                blurRadius: 20,
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.refresh,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      infoContainer("pess", "Bosim",
                                          listweather[0].pess!),
                                      infoContainer("wind", "Shamol",
                                          listweather[0].wind!),
                                      infoContainer("sun", "Quyosh ch",
                                          listweather[0].sun!)
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    infoContainer(
                                        "rain", "Namlik", listweather[0].rain!),
                                    infoContainer(
                                        "moon", "Oy", listweather[0].moon!),
                                    infoContainer("sunset", "Quyosh b",
                                        listweather[0].sunset!),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Haftalik Ob-Havo",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: topCityColor,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 30, bottom: 30),
                            height: 200,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var model = listweekly[index];
                                  return weeklyButton(
                                    model.day!,
                                    model.date!,
                                    "${wtypes[model.desc!.toLowerCase()]}",
                                    model.temp!,
                                    int.parse(model.rainPer!),
                                    _pressed == model.date!,
                                    () =>
                                        setState(() => _pressed = model.date!),
                                  );
                                },
                                itemCount: listweekly.length),
                          )
                        ],
                      )),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        'Error',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                } else {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              }),
            )),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    Key? key,
    required this.gradient,
    this.style,
  }) : super(key: key);

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
