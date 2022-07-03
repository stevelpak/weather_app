import 'package:flutter/material.dart';
import 'package:weather/utils/constants.dart';

Widget infoContainer(String icon, String title, String data) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Image.asset(
            "assets/info/$icon.png",
            scale: 5,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFCBCBCB),
                fontSize: 10,
              ),
            ),
            Text(
              data,
              style: TextStyle(
                color: topCityColor,
                fontSize: 10,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
