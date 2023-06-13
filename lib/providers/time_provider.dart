import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  Timer? _timer;
  int _hour = 0;
  int _second = 0;
  int _minute = 0;
  int _timerInSecond = 0;
  int _timerInMillisecond = 0;
  bool _startEnable = true;
  bool _stopEnable = false;
  bool _continueEnable = false;

  int get hour => _hour;
  int get minute => _minute;
  int get second => _second;
  int get timerInSecond => _timerInSecond;
  bool get startEnable => _startEnable;
  bool get stopEnable => _stopEnable;
  bool get continueEnable => _continueEnable;
  int get getTickTimer => _timer?.tick ?? 0;

  void tickTimerMillisecond() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 1),
      (timer) {
        _timerInMillisecond++;
        if (_timerInMillisecond % 999 == 0) {
          _timerInSecond++;
          if (_second < 59) {
            _second++;
          } else {
            _second = 0;
            if (_minute == 59) {
              _minute == 0;
              _hour++;
            } else {
              _minute++;
            }
          }
          notifyListeners();
        }
      },
    );
  }

  void tickTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _timerInSecond++;
        if (_second < 59) {
          _second++;
        } else {
          _second = 0;
          if (_minute == 59) {
            _minute == 0;
            _hour++;
          } else {
            _minute++;
          }
        }
        notifyListeners();
      },
    );
  }

  void startTimer() {
    resetTimer();
    _continueEnable = _startEnable = false;
    _stopEnable = true;
    if (_timer?.isActive == true) _timer?.cancel();
    //tickTimer();
    tickTimerMillisecond();
  }

  void stopTimer({bool notify = true}) {
    if (_startEnable == false) {
      _startEnable = _continueEnable = true;
      _stopEnable = false;
      _timer?.cancel();
      if (notify) notifyListeners();
    }
  }

  void resetTimer() {
    _hour = _minute = _second = _timerInSecond =_timerInMillisecond= 0;
  }

  void continueTimer() {
    //check this function
    if (_timer?.isActive == true) _timer?.cancel();
    _startEnable = _continueEnable = false;
    _stopEnable = true;
    tickTimer();
  }

  String getString() {
    String time = "";
    if (_hour != 0) {
      time += "$_hour:";
    }
    if (_minute != 0) {
      if (_hour != 0 && _minute < 10) time += "0";
      time += "$_minute:";
    }
    if (_second < 10) {
      time += "0";
    }
    time += _second.toString();
    return time;
  }

  int getTimeInSecond() {
    return _timerInSecond;
  }

  int getTimeInHundredthOfSecond() {
    return (_timerInMillisecond ~/ 10);
  }

  int getTimeInMillisecond()
  {
    return _timerInMillisecond;
  }
}
