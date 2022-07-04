import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart';

import 'package:weather/models/weather_model.dart';
import 'package:weather/utils/constants.dart';
import 'package:weather/widgets/weekly.dart';
import 'package:weather/widgets/info_con.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<WeatherModel> _listweather = [];

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

      _listweather.add(model);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 20,
            ),
            decoration: BoxDecoration(
              gradient: bgGradient,
            ),
            child: FutureBuilder(
              future: _listweather.isEmpty ? loadData() : null,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
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
                              TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.location_on_rounded,
                                  color: locationClr,
                                  size: 25,
                                ),
                                label: Text(
                                  "Fergana",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: topCityColor,
                                      fontWeight: FontWeight.bold),
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
                                  "Yangilanmoqda°",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 120, left: 20),
                                      child: Text(
                                        _listweather[0].desc!,
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Bugun\n${_listweather[0].curDay}",
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      GradientText(
                                        _listweather[0].temp!,
                                        gradient: textGradient,
                                        style: const TextStyle(
                                          fontSize: 75,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${_listweather[0].desc} ${_listweather[0].tempNight}",
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
                              "assets/states/sunrain.png",
                              scale: 3.5,
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
                                        padding:
                                            const EdgeInsets.only(right: 15),
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
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.08),
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
                                  infoContainer(
                                      "pess", "Bosim", _listweather[0].pess!),
                                  infoContainer(
                                      "wind", "Shamol", _listweather[0].wind!),
                                  infoContainer(
                                      "sun", "Quyosh ch", _listweather[0].sun!)
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                infoContainer(
                                    "rain", "Namlik", _listweather[0].rain!),
                                infoContainer(
                                    "moon", "Oy", _listweather[0].moon!),
                                infoContainer("sunset", "Quyosh b",
                                    _listweather[0].sunset!),
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
                        margin: const EdgeInsets.only(top: 30),
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            weeklyButton(
                                "Mon", 3, "Jul", "cloudy", 23, 10, true),
                            weeklyButton(
                                "Tue", 4, "Jul", "sunny", 33, 2, false),
                            weeklyButton(
                                "Wed", 5, "Jul", "sunny", 30, 42, false),
                            weeklyButton(
                                "Thu", 6, "Jul", "suncloud", 20, 72, false),
                          ],
                        ),
                      )
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
