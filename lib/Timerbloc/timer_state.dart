part of 'timer_bloc.dart';

enum TimerStatus {
  initial,
  running,
  finished,
}

class TimerState {
  int duration;
  final TimerStatus status;

  TimerState({
    this.duration = 3600,
    this.status = TimerStatus.initial,
  });

  TimerState copyWith({
    int? duration,
    TimerStatus? status,
  }) {
    return TimerState(
      duration: duration ?? this.duration,
      status: status ?? this.status,
    );
  }
}
