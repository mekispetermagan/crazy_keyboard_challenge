import 'dart:math';

class CountdownStatus {
  final int remainingSeconds;
  final int withinSecondMs;
  final bool isInDangerZone;
  final bool isRunning;
  const CountdownStatus({
    required this.remainingSeconds,
    required this.withinSecondMs,
    required this.isInDangerZone,
    required this.isRunning,
  });
}

class CountdownManager {
  int _totalSeconds;
  final int _dangerZoneSeconds;
  late int _startingMs;
  int _elapsedMs = 0;
  bool _isRunning = false;

  CountdownManager({
    required int totalSeconds,
    required int dangerZoneSeconds,
  })
    : assert(0 < totalSeconds, "totalSeconds should be positive: $totalSeconds"),
      assert(0 <= dangerZoneSeconds, "dangerZoneSeconds shouldn't be negative: $dangerZoneSeconds"),
      assert(
        dangerZoneSeconds < totalSeconds,
        "dangerZoneSeconds should be smaller than totalSeconds: $dangerZoneSeconds vs $totalSeconds"
      ),
      _totalSeconds = totalSeconds,
      _dangerZoneSeconds = dangerZoneSeconds;

  CountdownStatus get status {
    final int elapsedSeconds = _elapsedMs ~/ 1000;
    final int remainingSeconds = max(_totalSeconds - elapsedSeconds, 0);
    final int withinSecondMs = _elapsedMs % 1000;
    final bool isInDangerZone = remainingSeconds < _dangerZoneSeconds;
    return CountdownStatus(
      remainingSeconds: remainingSeconds,
      withinSecondMs: withinSecondMs,
      isInDangerZone: isInDangerZone,
      isRunning: _isRunning,
    );
  }

  set totalSeconds(int value) => _totalSeconds = value;

  void start(int tickerMs) {
    _isRunning = true;
    _startingMs = tickerMs - _elapsedMs;
  }

  void pause(int tickerMs) {
    update(tickerMs);
    _isRunning = false;
  }

  void update(int tickerMs) {
    if (_isRunning) {
      _elapsedMs = tickerMs - _startingMs;
      final int elapsedSeconds = _elapsedMs ~/ 1000;
      if (_totalSeconds <= elapsedSeconds) {_isRunning = false;}
    }
  }

  void reset(int tickerMs) {
    _startingMs = tickerMs;
    _elapsedMs = 0;
    _isRunning = false;
  }
}
