// Copyright 2020 Shakir Kasmani. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the tourbillon_clock/LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';

import 'package:vector_math/vector_math_64.dart' show radians;

import 'clock_dial.dart';
import 'clock_hand.dart';
import 'tickless_hand.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

/// Analog Clock with Decorated Hands and Tickless Hand Animation.
class BaseClock extends StatelessWidget {
  const BaseClock(
      {@required this.theme, DateTime now, @required this.controller})
      : _now = now,
        assert(theme != null),
        assert(now != null),
        assert(controller != null);

  final ThemeData theme;
  final DateTime _now;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.Hm().format(DateTime.now());

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Tourbillon clock with time $time',
        value: time,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          /// Clock Face
          ClockDial(
            markColor: theme.primaryColor,
          ),

          /// Tickless Second Hand
          TicklessHand(
            color: theme.primaryColor,
            controller: controller,
            size: 0.92,
          ),

          /// Minute Hand
          ClockHand(
            size: 0.85,
            angleRadians: _now.minute * radiansPerTick,
            child: Transform.translate(
              offset: Offset(0, -92.0),
              child: Container(
                height: 192,
                width: 29,
                decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(21),
                    border: Border.all(color: theme.primaryColor, width: 7.2)),
              ),
            ),
          ),

          /// Hour Hand
          ClockHand(
            size: 0.63,
            angleRadians: _now.hour * radiansPerHour +
                (_now.minute / 60) * radiansPerHour,
            child: Transform.translate(
              offset: Offset(0, -88.0),
              child: Container(
                height: 192,
                width: 35,
                decoration: ShapeDecoration(
                  color: theme.primaryColor,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),

          /// Top cover
          Container(
            height: 25,
            width: 25,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: theme.accentColor),
          )
        ],
      ),
    );
  }
}
