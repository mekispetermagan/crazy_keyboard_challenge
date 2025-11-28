import 'package:flutter/material.dart';
import  'dart:math';
import 'positioned_widgets.dart';

class CircleKeyboard {
  late final List<Widget> keys;
  final double keySize;
  final double x0;
  final double y0;
  final double angle;
  final void Function(String)? onKeyPress;
  CircleKeyboard({
    required this.keySize,
    required this.x0,
    required this.y0,
    required this.angle,
    required this.onKeyPress,
  }) {
    keys = [
    ..._buttonRowOnCircle(
      letters: "QWERTYUIOP",
      size: keySize,
      x0: x0,
      y0: y0,
      r: 150,
      startAngle: angle,
      clockwise: true
    ),
    ..._buttonRowOnCircle(
      letters: "ASDFGHJKL",
      size: keySize,
      x0: x0,
      y0: y0,
      r: 105,
      startAngle: angle,
      clockwise: false
    ),
      ..._buttonRowOnCircle(
      letters: "ZXCVBNM",
      size: keySize,
      x0: x0,
      y0: y0,
      r: 60,
      startAngle: angle,
      clockwise: true
    ),
    LetterButton(
      letter: " ",
      size: keySize,
      x: x0,
      y: y0,
      onPressed: onKeyPress,
    ),
    BackspaceButton(
      x: 2*x0-60,
      y: y0-180,
      onPressed: onKeyPress,
    ),
    ResetButton(
      x: 2*x0-105,
      y: y0-180,
      onPressed: onKeyPress,
    ),
  ];
  }

  List<LetterButton> _buttonRowOnCircle({
    required String letters,
    required double size,
    required double x0,
    required double y0,
    required double r,
    required double startAngle,
    bool clockwise = true,
  }) {

    double getCircleX(x0, angle, radius) {
      final double angleRad = angle / 180 * pi;
      return x0 + cos(angleRad) * radius;
    }

    double getCircleY(y0, angle, radius) {
      final double angleRad = angle / 180 * pi;
      return y0 + sin(angleRad) * radius;
    }

    if (letters.isEmpty) return [...[]];
    double angleDiff = 360 / letters.length;
    return [
      for (int i=0; i<letters.length; i++)
        LetterButton(
          letter: letters[i],
          size: size,
          x: getCircleX(
            x0,
            clockwise ? startAngle + i*angleDiff : -startAngle - i*angleDiff,
            r
          ),
          y: getCircleY(
            y0,
            clockwise ? startAngle + i*angleDiff : -startAngle - i*angleDiff,
            r
          ),
          onPressed: onKeyPress,
        )
    ];
  }
}

class MarqueeKeyboard {
  late final List<Widget> keys;
  final double keySize;
  final double x0;
  final double y0;
  final double angle;
  final void Function(String)? onKeyPress;
  MarqueeKeyboard({
    required this.keySize,
    required this.x0,
    required this.y0,
    required this.angle,
    required this.onKeyPress,
  }) {
    keys = [
    ..._buttonRow(
      letters: "QWERTYUIOP",
      size: keySize,
      x0: x0,
      y0: y0-2.25*keySize,
      startAngle: angle,
      clockwise: true
    ),
    ..._buttonRow(
      letters: "ASDFGHJKL",
      size: keySize,
      x0: x0,
      y0: y0-0.75*keySize,
      startAngle: angle,
      clockwise: false
    ),
      ..._buttonRow(
      letters: "ZXCVBNM",
      size: keySize,
      x0: x0,
      y0: y0+0.75*keySize,
      startAngle: angle,
      clockwise: true
    ),
    SpaceButton(
      size: keySize,
      x: x0,
      y: y0+2.25*keySize,
      onPressed: onKeyPress,
    ),
    BackspaceButton(
      x: x0+3*keySize,
      y: y0+2.25*keySize,
      onPressed: onKeyPress,
    ),
    ResetButton(
      x: x0-3*keySize,
      y: y0+2.25*keySize,
      onPressed: onKeyPress,
    ),
  ];
  }

  List<LetterButton> _buttonRow({
    required String letters,
    required double size,
    required double x0,
    required double y0,
    required double startAngle,
    bool clockwise = true,
  }) {

    if (letters.isEmpty) return [...[]];
    return [
      for (int i=0; i<letters.length; i++)
        LetterButton(
          letter: letters[i],
          size: size,
          x: clockwise
            ? (x0 - letters.length/2*keySize + i*keySize +4*angle) % (2*x0+size)
            : (x0 - letters.length/2*keySize + i*keySize -4*angle) % (2*x0+size)
            ,
          y: y0,
          onPressed: onKeyPress,
        )
    ];
  }
}

