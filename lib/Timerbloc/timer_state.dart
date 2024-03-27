part of 'timer_bloc.dart';

enum TimerStatus {
  initial,
  running,
  paused,
  finished,
}

class TimerState {
  int duration;
  int length;
  final TimerStatus status;

  TimerState({
    this.duration = 3600,
    this.length = 3600,
    this.status = TimerStatus.initial,
  });

  TimerState copyWith({
    int? duration,
    int? length,
    TimerStatus? status,
  }) {
    return TimerState(
      duration: duration ?? this.duration,
      status: status ?? this.status,
      length: length ?? this.length,
    );
  }
}
