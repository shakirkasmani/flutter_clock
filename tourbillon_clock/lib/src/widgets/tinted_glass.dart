// Copyright 2020 Shakir Kasmani. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class TintedGlass extends StatelessWidget {
  const TintedGlass({
    @required this.diameter,
    @required this.color,
  });

  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: diameter,
      width: diameter,
      decoration:
          BoxDecoration(color: color.withOpacity(0.72), shape: BoxShape.circle),
    );
  }
}
