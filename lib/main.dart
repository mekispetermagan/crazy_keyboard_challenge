import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/scheduler.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'game_logic.dart';
import 'screens.dart';

enum Status {title, game, result}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        fontFamily: GoogleFonts.ubuntuMono().fontFamily,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
  with SingleTickerProviderStateMixin {
  Status _status = Status.title;
  late final Ticker _ticker;
  late final Future<List<Map<String, dynamic>>> _dataFuture;
  TypingManager? _challengeManager;
  final double _angleSpeed = 6; // deg/s
  double _angle = 0;
  String _typedText = "";
  String? _challengeText;
  int _score = 0;

  _HomePageState();

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
    _dataFuture = loadDataAsset(
      kIsWeb ? "data/data.json" : "assets/data/data.json",
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _onStart() {
    _nextChallenge();
    setState((){
      _status = Status.game;
    });
  }

  void _onTick(Duration elapsed) {
    setState(() {
    _angle = (elapsed.inMilliseconds / 1000 *_angleSpeed) % 360;
    });
  }

  void _onKeyPress(String input) {
    setState((){
      if (input == "reset") {
        _typedText = "";
        return;
      }
      if (input == "backspace" &&_typedText.isNotEmpty) {
        _typedText = _typedText.substring(0, _typedText.length-1);
        return;
      }
      _typedText += input;
    });

    if (_typedText == _challengeText) {
      _score++;
      _nextChallenge();
    }
  }

  _nextChallenge() {
    if (0 < _score && _score % 12 == 0) {
      final bool _ = _challengeManager!.advanceLevel();
    }
    setState((){
      _challengeText = _challengeManager!.createChallenge();
      _typedText = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        // loading in progress
        if (snapshot.connectionState == ConnectionState.waiting) {
          return TitleScreen(onStart: null);
        }
        // loading error
        if (snapshot.hasError) {
          return Center(child: Text("Uh oh... ${snapshot.error}"));
        }
        final data = snapshot.data;
        // no data error
        if (data == null) {
          return Center(child: Text("Uh oh... No data."));
        }
        _challengeManager ??= TypingManager.fromJson(
          challengesRaw: data);
        return switch (_status) {
          Status.title => TitleScreen(onStart: _onStart,),
          Status.game => GameScreen(
            challengeText: _challengeText!,
            typedText: _typedText,
            angle: _angle,
            onKeyPress: _onKeyPress,
          ),
          Status.result => ResultScreen(),
        };
      },
    );




  }
}

/// Loads data from a JSON asset and validates that
/// - it is a list
/// - its elements are maps with string keys
/// Further validation and processing is done by [_exerciseManager].
Future<List<Map<String, dynamic>>> loadDataAsset(String assetPath) async {
  final text = await rootBundle.loadString(assetPath);
  final list = jsonDecode(text);
  // malformed json: not a list
  if (list is! List) {
    throw const FormatException('Top-level JSON must be a list.');
  }
  final decoded = list.map((e) {
    // malformed json: items are not maps with string keys
    if (e is! Map<String, dynamic>) {
      throw const FormatException(
        'Each item in the list must be an object.',
      );
    }
    return e;
  }).toList();
  return decoded;
}

void main() {
  LicenseRegistry.addLicense(() async* {
    final String license = await rootBundle.loadString('fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(<String>['google_fonts'], license);
  });
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const _App());
}
