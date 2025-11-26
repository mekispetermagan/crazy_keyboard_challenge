import 'package:flutter/material.dart';
import 'package:typing/countdown_logic.dart';
import 'package:typing/countdown_widgets.dart';
// import  'dart:math';

/// Center-positioned widgets

enum Role {
  primary,
  secondary,
  tertiary,
  error;

  Color bg(ColorScheme c) => switch (this) {
    Role.primary => c.primaryContainer,
    Role.secondary => c.secondaryContainer,
    Role.tertiary => c.tertiaryContainer,
    Role.error => c.errorContainer,
  };

  Color fg(ColorScheme c) => switch (this) {
    Role.primary => c.onPrimaryContainer,
    Role.secondary => c.onSecondaryContainer,
    Role.tertiary => c.onTertiaryContainer,
    Role.error => c.onErrorContainer,
  };
}

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
  final void Function(String)? onPressed;
  final Role role;

  const LetterButton({
    required this.letter,
    required this.size,
    required this.x,
    required this.y,
    required this.onPressed,
    this.role = Role.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final op = onPressed;
    return CenterPositioned(
      x: x,
      y: y,
      child: SizedBox(
        width: size,
        height: size,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextButton(
            onPressed: () => op != null ? op(letter) : null,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(role.bg(cs)),
              foregroundColor: WidgetStatePropertyAll(role.fg(cs)),
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
  final void Function(String)? onPressed;
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
  final op = onPressed;
    return CenterPositioned(
      x: x,
      y: y,
      child: IconButton(
        onPressed: () => op != null ? op(editMessage) : null,
        iconSize: 36,
        icon: icon,
      ),
    );
  }
}

class ResetButton extends StatelessWidget {
  final double x;
  final double y;
  final void Function(String)? onPressed;

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
  final void Function(String)? onPressed;

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

class PositionedTextCard extends StatelessWidget {
  final String text;
  final double x;
  final double y;
  final Role role;
  final double fontSize;
  const PositionedTextCard({
    required this.text,
    required this.x,
    required this.y,
    this.role = Role.primary,
    this.fontSize = 24,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return CenterPositioned(
      x: x,
      y: y,
      child: Card(
        color: role.bg(cs),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              color: role.fg(cs),
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

class PositionedCountdownTimer extends StatelessWidget {
  final CountdownStatus status;
  final double baseSize;
  final double x;
  final double y;
  const PositionedCountdownTimer({
    required this.status,
    required this.baseSize,
    required this.x,
    required this.y,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CenterPositioned(
      x: x,
      y: y,
      child: CountdownTimer(
        status: status,
        baseSize: baseSize)
    );
  }
}