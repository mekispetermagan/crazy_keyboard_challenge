import 'package:flutter/material.dart';
// import  'dart:math';

class LetterButton extends StatelessWidget {
  final String letter;
  final double size;
  final double x;
  final double y;
  final void Function(String) onPressed;

  const LetterButton({
    required this.letter,
    required this.size,
    required this.x,
    required this.y,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x-size/2,
      top: y-size/2,
      width: size,
      height: size,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: TextButton(
          onPressed: () => onPressed(letter),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
            foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onPrimaryContainer),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            side:WidgetStatePropertyAll(BorderSide(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              width: 2,
            )),
          ),
          child: Text(
            letter,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
      ),
    );
  }
}

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

class PositionedText extends StatelessWidget {
  final String text;
  final double x;
  final double y;
  const PositionedText({
    required this.text,
    required this.x,
    required this.y,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: y,
      child: SizedBox(
        width: x * 2,
        height: 60,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
          ),
          ),
      ),
    );
  }
}
