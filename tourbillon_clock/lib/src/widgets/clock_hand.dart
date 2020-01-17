// Copyright 2020 Shakir Kasmani. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the tourbillon_clock/LICENSE file.

import 'package:flutter/material.dart';

class ClockHand extends StatelessWidget {
  const ClockHand({
    @required this.size,
    @required this.angleRadians,
    this.child,
  })  : assert(size != null),
        assert(angleRadians != null);

  /// The child widget used as the clock hand and rotated by [angleRadians].
  final Widget child;

  /// Hand length, as a percentage of the smaller side of the clock's parent
  /// container.
  final double size;

  /// The angle, in radians, at which the hand is drawn.
  ///
  /// This angle is measured from the 12 o'clock position.
  final double angleRadians;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: Transform.rotate(
          angle: angleRadians,
          alignment: Alignment.center,
          child: Transform.scale(
            scale: size,
            alignment: Alignment.center,
            child: Container(child: Center(child: child)),
          ),
        ),
      ),
    );
  }
}
