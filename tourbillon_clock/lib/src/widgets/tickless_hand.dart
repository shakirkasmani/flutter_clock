// Copyright 2020 Shakir Kasmani. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the tourbillon_clock/LICENSE file.

import 'package:flutter/material.dart';

class TicklessHand extends AnimatedWidget {
  const TicklessHand(
      {Key key,
      @required this.size,
      @required this.color,
      AnimationController controller})
      : assert(controller != null),
        super(key: key, listenable: controller);

  final double size;
  final Color color;
  Animation<double> get _progress => listenable;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _progress,
      child: Center(
        child: SizedBox.expand(
          child: Container(
            child: Transform.scale(
              scale: size,
              alignment: Alignment.center,
              child: Container(
                child: Center(
                  child: Transform.translate(
                    offset: Offset(0.0, -63.0),
                    child: Container(
                      width: 7,
                      height: 221,
                      decoration: ShapeDecoration(
                        color: color,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(11)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
