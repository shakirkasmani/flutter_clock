// Copyright 2020 Shakir Kasmani. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the tourbillon_clock/LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';

class ClockDial extends StatelessWidget {
  const ClockDial({Key key, @required this.markColor}) : super(key: key);

  final Color markColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _DialPainter(markColor: markColor),
      ),
    );
  }
}

class _DialPainter extends CustomPainter {
  _DialPainter({@required this.markColor})
      : tickPaint = new Paint(),
        textPainter = new TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        textStyle = TextStyle(
            color: markColor,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'LibreBaskerville') {
    tickPaint.color = markColor;
  }

  final Color markColor;

  final secTickMarkLength = 15.0;
  final boldTickMarkWidth = 4.0;
  final secTickMarkWidth = 2.0;

  final hourTickMarkLength = 35;
  final hourTickMarkWidth = 5.0;

  final Paint tickPaint;
  final TextPainter textPainter;
  final TextStyle textStyle;

  final romanNumeralList = ['XII', 'III', 'VI', 'IX'];

  @override
  void paint(Canvas canvas, Size size) {
    final padding = 25.0;
    final angle = 2 * pi / 60;
    final radius = (size.shortestSide - padding) / 2;
    final secMarkOffsetY = hourTickMarkLength + 15.0 - radius;
    final textOffsetY = 15.0 - radius;

    canvas.save();

    // Sets the position of the canvas to the center of the layout
    canvas.translate(size.width / 2, size.height / 2);
    for (var i = 0; i < 60; i++) {
      //draw second mark
      tickPaint.strokeWidth = i % 5 == 0 ? boldTickMarkWidth : secTickMarkWidth;
      canvas.drawLine(Offset(0.0, secMarkOffsetY),
          Offset(0.0, secMarkOffsetY + secTickMarkLength), tickPaint);

      //draw hour mark
      tickPaint.strokeWidth = hourTickMarkWidth;
      if (i % 5 == 0 && i % 15 != 0) {
        canvas.drawLine(Offset(0.0, -radius),
            Offset(0.0, -radius + hourTickMarkLength), tickPaint);
      }

      //draw hour text
      if (i % 15 == 0) {
        canvas.save();
        canvas.translate(0.0, textOffsetY);

        textPainter.text = TextSpan(
          text: '${romanNumeralList[i ~/ 15]}',
          style: textStyle,
        );

        textPainter.layout();
        textPainter.paint(canvas,
            Offset(-(textPainter.width / 2), -(textPainter.height / 2)));
        canvas.restore();
      }
      canvas.rotate(angle);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    //We have no reason to repaint so we return false.
    return false;
  }
}
