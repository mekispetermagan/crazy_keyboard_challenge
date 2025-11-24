import 'package:flutter/material.dart';
// import  'dart:math';
import 'base_widgets.dart' show PrimaryActionButton, PositionedText;
import 'package:typing/keyboards.dart';

class TitleScreen extends StatelessWidget {
  final VoidCallback? onStart;
  const TitleScreen({
    required this.onStart,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Crazy Keyboard Challenge",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
                PrimaryActionButton(
                  text: onStart != null ? "Start" : "Wait...",
                  onPressed: onStart
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameScreen extends StatelessWidget {
  final String challengeText;
  final String typedText;
  final double angle;
  final void Function(String) onKeyPress;
  const GameScreen({
    required this.challengeText,
    required this.typedText,
    required this.angle,
    required this.onKeyPress,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crazy Keyboard Challenge"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: SafeArea(
        child: SizedBox(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // const horizontalPadding = 24.0;

              final width = constraints.maxWidth ;
              final height = constraints.maxHeight;

              final double keySize = 42;

              final double x0 = width / 2;
              final double y0 = height / 2;

              return Center(
                child: SizedBox(
                  width: width,
                  child: Stack(
                    children: <Widget>[
                      PositionedText(
                        text: challengeText,
                        x: x0,
                        y: 0,
                      ),
                      PositionedText(
                        text: typedText,
                        x: x0,
                        y: 60,
                      ),
                    ...CircleKeyboard(
                      keySize: keySize,
                      x0: x0,
                      y0: y0,
                      angle: angle,
                      onKeyPress: onKeyPress,
                    ).keys,
                    ]
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("How did you get here?"))
    );
  }
}