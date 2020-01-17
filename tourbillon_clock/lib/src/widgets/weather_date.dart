// Copyright 2020 Shakir Kasmani. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the tourbillon_clock/LICENSE file.

import 'package:flutter/material.dart';

/// Weather and Date information widget.
class WeatherDate extends StatelessWidget {
  const WeatherDate({
    @required this.color,
    @required this.temperature,
    @required this.condition,
    @required this.date,
  })  : assert(color != null),
        assert(temperature != null),
        assert(condition != null),
        assert(date != null);

  final Color color;
  final String temperature;
  final String condition;
  final String date;

  /// Clock TextStyle for Weather and Date information.
  TextStyle clockTextStyle(double fontSize) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontFamily: 'LibreBaskerville',
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 11, bottom: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Weather with condition icon.
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text('$temperature', style: clockTextStyle(35)),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                    height: 35,
                    child: Image.asset('assets/$condition.png',
                        fit: BoxFit.contain)),
              )
            ],
          ),

          /// Day and Date.
          Text(
            date.toUpperCase(),
            style: clockTextStyle(25),
          ),
        ],
      ),
    );
  }
}
