
import 'dart:async';
import 'dart:ui';

final DeBouncer deBouncer = DeBouncer(delay: const Duration(milliseconds: 700));
class DeBouncer {
  Duration delay;
  late Timer timer = Timer(const Duration(milliseconds: 700), flush);
  late VoidCallback callback;

  DeBouncer({this.delay = const Duration(milliseconds: 700)});

  void debounce(VoidCallback callback) {
    this.callback = callback;
    cancel();
    timer = Timer(delay, flush);
  }

  void cancel() {
    if (timer!=null) {
      timer.cancel();
    }
  }

  void flush() {
    callback();
    cancel();
  }
}

final DeBouncerTime deBouncerTime = DeBouncerTime(delay: const Duration(milliseconds:900));
class DeBouncerTime {
  Duration delay;
  late Timer timer = Timer(const Duration(milliseconds: 900), flush);
  late VoidCallback callback;

  DeBouncerTime({this.delay = const Duration(milliseconds: 900)});

  void debounceTime(VoidCallback callback) {
    this.callback = callback;
    cancel();
    timer = Timer(delay, flush);
  }

  void cancel() {
    if (timer!=null) {
      timer.cancel();
    }
  }

  void flush() {
    callback();
    cancel();
  }
}