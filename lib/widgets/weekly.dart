import 'package:flutter/cupertino.dart';
import 'package:weather/utils/constants.dart';

Widget weeklyButton(
    String day, String dm, String icon, String temp, int hum, bool isActive) {
  BoxDecoration currDec = isActive ? activeDay : noActiveDay;
  Color dayColor = isActive ? white : topCityColor;
  Color tempColor = isActive ? dateTextColor : topCityColor;
  Color currColor = isActive ? dateTextColor : notActiveDateColor;
  Color currHumClr = humidityGoodClr;

  if (hum > 40 && hum < 60) {
    currHumClr = humidityHmColor;
  } else if (hum > 60) {
    currHumClr = humidityBadClrg;
  }

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
    decoration: currDec,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            day,
            style: TextStyle(
              color: dayColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          dm,
          style: TextStyle(
            color: currColor,
            fontSize: 10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Image.asset(
            "assets/types/$icon.png",
            width: 40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            temp,
            style: TextStyle(
                color: tempColor, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: currHumClr,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "$hum%",
            style: TextStyle(
              color: white,
              fontSize: 10,
            ),
          ),
        )
      ],
    ),
  );
}
