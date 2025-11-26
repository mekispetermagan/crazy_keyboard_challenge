import 'package:flutter/material.dart';
import 'package:typing/countdown_logic.dart';
// import 'package:typing/countdown_widgets.dart';
// import  'dart:math';
import 'positioned_widgets.dart';
import 'package:typing/keyboards.dart';

class PrimaryActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const PrimaryActionButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(colorScheme.primaryContainer),
        foregroundColor: WidgetStatePropertyAll(colorScheme.onPrimaryContainer),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(text, style: TextStyle(fontSize: 30)),
      ),
    );
  }
}

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
  final void Function(String)? onKeyPress;
  final CountdownStatus countdownStatus;
  const GameScreen({
    required this.challengeText,
    required this.typedText,
    required this.angle,
    required this.onKeyPress,
    required this.countdownStatus,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Crazy Keyboard Challenge"),
      //   backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      //   foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      // ),
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
                      PositionedTextCard(
                        text: challengeText,
                        x: x0,
                        y: 60,
                        role:Role.secondary,
                        fontSize: 30,
                      ),
                      PositionedTextCard(
                        text: typedText,
                        x: x0,
                        y: 150,
                        role: Role.tertiary,
                        fontSize: 30,
                      ),
                      ...CircleKeyboard(
                        keySize: keySize,
                        x0: x0,
                        y0: y0,
                        angle: angle,
                        onKeyPress: onKeyPress,
                      ).keys,
                      PositionedCountdownTimer(
                        status: countdownStatus,
                        baseSize: 30,
                        x: x0,
                        y: height-150,
                      ),
                      LivesDisplay(
                        lives: 3,
                        maxLives: 5,
                        x: width/4,
                        y: height-45,
                      ),
                      PositionedTextCard(
                        text: "32544",
                        x: width*3/4,
                        y:height-45,
                        role: Role.tertiary,
                      ),
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