// Copyright 2020 Shakir Kasmani. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

/// Tourbillon mechanism animation widget.
class Tourbillon extends AnimatedWidget {
  const Tourbillon(
      {Key key,
      @required this.diameter,
      @required this.background,
      AnimationController controller})
      : assert(diameter != null),
        assert(background != null),
        assert(controller != null),
        super(key: key, listenable: controller);

  final double diameter;
  final Color background;
  Animation<double> get _progress => listenable;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          child: Container(
            height: diameter,
            width: diameter,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: background),
          ),
        ),
        Container(
          height: diameter,
          width: diameter,
          child: Center(
            child: RotationTransition(
              turns: _progress,
              child: FlareActor(
                'animations/tourbillon.flr',
                animation: 'second',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
