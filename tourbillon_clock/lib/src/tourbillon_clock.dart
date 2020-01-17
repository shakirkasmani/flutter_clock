// Copyright 2020 Shakir Kasmani. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the tourbillon_clock/LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';

import 'widgets/base_clock.dart';
import 'widgets/tinted_glass.dart';
import 'widgets/tourbillon.dart';
import 'widgets/weather_date.dart';

class TourbillonClock extends StatefulWidget {
  const TourbillonClock(this.model);

  final ClockModel model;

  @override
  _TourbillonClockState createState() => _TourbillonClockState();
}

class _TourbillonClockState extends State<TourbillonClock>
    with SingleTickerProviderStateMixin {
  var _now = DateTime.now();
  var _temperature = '';
  var _condition = '';
  Timer _timer;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
    _controller = AnimationController(
        value: _preciseTime() / 60,
        duration: Duration(
          seconds: 60,
        ),
        vsync: this)
      ..repeat();
  }

  @override
  void didUpdateWidget(TourbillonClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    _controller.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _temperature = _temperature.substring(0, 2) + _temperature.substring(4);
      _condition = widget.model.weatherString.toLowerCase();
    });
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  /// Accurate time for initiating animation
  double _preciseTime() {
    return _now.second + (_now.millisecond / 1000);
  }

  @override
  Widget build(BuildContext context) {
    final clockTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
            primaryColor: Color(0xFF423E37),
            canvasColor: Color(0xFFFFFFF2),
            accentColor: Color(0xFFFFD54F),
            backgroundColor: Color(0xFF423629),
          )
        : Theme.of(context).copyWith(
            primaryColor: Color(0xFFBDC1C6),
            canvasColor: Color(0xFF35363A),
            accentColor: Color(0xFFFFD54F),
            backgroundColor: Color(0xFF202124),
          );

    final scale = MediaQuery.of(context).size.height / 3;
    final date = DateFormat('EEEE,\nMMMM dd').format(_now);

    return Container(
      decoration: BoxDecoration(color: clockTheme.canvasColor),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    WeatherDate(
                      date: date,
                      color: clockTheme.primaryColor,
                      condition: _condition,
                      temperature: _temperature,
                    )
                  ],
                ),
              )),
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Tourbillon(
                  diameter: scale * 1.5,
                  background: clockTheme.backgroundColor,
                  controller: _controller,
                ),
                TintedGlass(
                    diameter: scale * 1.5, color: clockTheme.canvasColor),
                BaseClock(
                  theme: clockTheme,
                  now: _now,
                  controller: _controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
