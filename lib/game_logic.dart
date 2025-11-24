import 'dart:math';

/// Immutable typing challenge model owned by [TypingManager].
///
/// Invariants:
/// - [level] is a positive integer (>= 1).
/// - [text] is the exact challenge text presented to the user.
class _TypingChallenge {
  final int level;
  final String text;

  _TypingChallenge({
    required this.level,
    required this.text,
  }) {
    if (level <= 0) {
      throw ArgumentError.value(level, 'level', 'must be > 0.');
    }
  }

  factory _TypingChallenge.fromJson(Map<String, dynamic> json) {
    final l = json["l"];
    final t = json["t"];

    if (l is! int) {
      throw const FormatException("Malformed challenge: 'l' must be an int.");
    }
    if (t is! String) {
      throw const FormatException("Malformed challenge: 't' must be a string.");
    }

    return _TypingChallenge(level: l, text: t);
  }
} // _TypingChallenge

/// Core game logic and state for the typing exercise feature.
///
/// Responsible for:
/// - validating and holding the full challenge set,
/// - tracking the current level,
/// - selecting random challenges per level for the UI.
class TypingManager {
  final List<_TypingChallenge> _challenges;
  int _currentLevel = 1;
  late final int _maxLevel;
  String? _currentText;
  final Random _random;

  /// Internal canonical constructor.
  ///
  /// Expects a fully parsed, valid list of [_TypingChallenge]s.
  /// Callers should normally use [TypingManager.fromJson].
  TypingManager._({
    required List<_TypingChallenge> challenges,
    Random? random,
  })
   : _challenges = List.unmodifiable(challenges),
     _random = random ?? Random()
  {
    _validateData();
  }

  /// Builds a [TypingManager] from decoded JSON objects.
  ///
  /// [challengesRaw] must be a list of maps with:
  /// - `"l"`: int >= 1 (level),
  /// - `"t"`: String (challenge text).
  ///
  /// Throws [FormatException] if the data is malformed or levels are not
  /// contiguous from 1 to max.
  TypingManager.fromJson({
    required List<Map<String, dynamic>> challengesRaw
    , Random? random,
  })
    : this._(
      challenges: [for (Map<String, dynamic> item in challengesRaw) _TypingChallenge.fromJson(item)],
      random: random,
      );

  int get maxLevel => _maxLevel;
  int get currentLevel => _currentLevel;
  String? get currentChallenge => _currentText;

  void _validateData() {
    if (_challenges.isEmpty) {throw FormatException("Empty challenge list.");}
    final Set<int> levels = {for (_TypingChallenge challenge in _challenges) challenge.level};
    _maxLevel = levels.reduce(max);
    for (int i=1; i<_maxLevel; i++) {
      if (!levels.contains(i)) {throw FormatException("Missing level: $i.");}
    }
  }

  String createChallenge() {
    List<_TypingChallenge> lvlChallenges = _challenges.where((item)
      => item.level == _currentLevel
    ).toList();
    _currentText = lvlChallenges.isNotEmpty
      ? lvlChallenges[_random.nextInt(lvlChallenges.length)].text : null;
    return _currentText!;
  }

  bool advanceLevel() {
    final bool success = _currentLevel < maxLevel;
    if (success) _currentLevel++;
    return success;
  }
} // TypingManager
