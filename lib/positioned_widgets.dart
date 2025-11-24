import 'package:flutter/material.dart';
// import  'dart:math';

/// Center-positioned widgets

class CenterPositioned extends StatelessWidget {
  final double x;
  final double y;
  final Widget child;
  const CenterPositioned({
    required this.x,
    required this.y,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: child,
        ),
    );
  }
}

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
    return CenterPositioned(
      x: x,
      y: y,
      child: SizedBox(
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
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  final double x;
  final double y;
  final void Function(String) onPressed;
  final String editMessage;
  final Icon icon;

  const EditButton({
    required this.x,
    required this.y,
    required this.onPressed,
    required this.editMessage,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CenterPositioned(
      x: x,
      y: y,
      child: IconButton(
        onPressed: () => onPressed(editMessage),
        iconSize: 36,
        icon: icon,
      ),
    );
  }
}

class ResetButton extends StatelessWidget {
  final double x;
  final double y;
  final void Function(String) onPressed;

  const ResetButton({
    required this.x,
    required this.y,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return EditButton(
      x: x,
      y: y,
      onPressed: onPressed,
      editMessage: "reset",
      icon: Icon(Icons.restart_alt_rounded),
    );
  }
}

class BackspaceButton extends StatelessWidget {
  final double x;
  final double y;
  final void Function(String) onPressed;

  const BackspaceButton({
    required this.x,
    required this.y,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return EditButton(
      x: x,
      y: y,
      onPressed: onPressed,
      editMessage: "backspace",
      icon: Icon(Icons.backspace_rounded)
    );
  }
}

class PositionedText extends StatelessWidget {
  final String text;
  final double x;
  final double y;
  final Color? backgroundColor;
  const PositionedText({
    required this.text,
    required this.x,
    required this.y,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CenterPositioned(
      x: x,
      y: y,
      child: Card(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              backgroundColor: backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}

class LivesDisplay extends StatelessWidget {
  final int lives;
  final int maxLives;
  final double x;
  final double y;
  const LivesDisplay({
    required this.lives,
    required this.maxLives,
    required this.x,
    required this.y,
    super.key,
  }) : assert(lives <= maxLives, "lives cannot exceed maxLives"),
       assert(0 <= lives, "lives cannot be negative");

  @override
  Widget build(BuildContext context) {
    return CenterPositioned(
      x: x,
      y: y,
      child: Row(
        children: <Widget>[
          for (int i=0; i<maxLives; i++)
            i < lives
            ? Icon(
                Icons.favorite_rounded,
                color: Colors.green[800],
                size: 30,
              )
            : Icon(
                Icons.heart_broken_rounded,
                color: Colors.red[800],
                size: 30,
              )
        ],
      ),
    );
  }

}