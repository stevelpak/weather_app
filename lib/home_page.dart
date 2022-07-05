import 'package:flutter/material.dart';

import 'package:weather/utils/constants.dart';
import 'package:weather/widgets/weekly.dart';
import 'package:weather/widgets/info_con.dart';
import 'package:weather/load_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  String dropDownValue = 'Ferghana';
  bool _pressed = false;

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
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
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
                                DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    menuMaxHeight: 300,
                                    value: dropDownValue,
                                    icon: const Visibility(
                                      visible: false,
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    items: cities.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: topCityColor),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropDownValue = newValue!;
                                        loadData(dropDownValue);
                                      });
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
                                        onTap: () => setState(() {
                                          loadData(dropDownValue);
                                        }),
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
                            margin: const EdgeInsets.only(top: 30),
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                InkWell(
                                  onTap: () => setState(() {
                                    _pressed = !_pressed;
                                  }),
                                  child: weeklyButton(
                                      listweekly[0].day!,
                                      listweekly[0].date!,
                                      "${wtypes[listweekly[0].desc!.toLowerCase()]}",
                                      listweekly[0].temp!,
                                      10,
                                      _pressed),
                                ),
                                InkWell(
                                  onTap: () => setState(() {
                                    _pressed = !_pressed;
                                  }),
                                  child: weeklyButton(
                                      listweekly[1].day!,
                                      listweekly[1].date!,
                                      "${wtypes[listweekly[1].desc!.toLowerCase()]}",
                                      listweekly[1].temp!,
                                      2,
                                      _pressed),
                                ),
                                InkWell(
                                  onTap: () => setState(() {
                                    _pressed = !_pressed;
                                  }),
                                  child: weeklyButton(
                                      listweekly[2].day!,
                                      listweekly[2].date!,
                                      "${wtypes[listweekly[2].desc!.toLowerCase()]}",
                                      listweekly[2].temp!,
                                      2,
                                      _pressed),
                                ),
                                InkWell(
                                  onTap: () => setState(() {
                                    _pressed = !_pressed;
                                  }),
                                  child: weeklyButton(
                                      listweekly[3].day!,
                                      listweekly[3].date!,
                                      "${wtypes[listweekly[3].desc!.toLowerCase()]}",
                                      listweekly[3].temp!,
                                      2,
                                      _pressed),
                                ),
                                InkWell(
                                  onTap: () => setState(() {
                                    _pressed = !_pressed;
                                  }),
                                  child: weeklyButton(
                                      listweekly[4].day!,
                                      listweekly[4].date!,
                                      "${wtypes[listweekly[4].desc!.toLowerCase()]}",
                                      listweekly[4].temp!,
                                      2,
                                      _pressed),
                                ),
                                InkWell(
                                  onTap: () => setState(() {
                                    _pressed = !_pressed;
                                  }),
                                  child: weeklyButton(
                                      listweekly[5].day!,
                                      listweekly[5].date!,
                                      "${wtypes[listweekly[5].desc!.toLowerCase()]}",
                                      listweekly[5].temp!,
                                      2,
                                      _pressed),
                                ),
                                InkWell(
                                  onTap: () => setState(() {
                                    _pressed = !_pressed;
                                  }),
                                  child: weeklyButton(
                                      listweekly[6].day!,
                                      listweekly[6].date!,
                                      "${wtypes[listweekly[6].desc!.toLowerCase()]}",
                                      listweekly[6].temp!,
                                      2,
                                      _pressed),
                                ),
                              ],
                            ),
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
