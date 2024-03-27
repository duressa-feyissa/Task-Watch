part of 'timer_bloc.dart';

class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStarted extends TimerEvent {
  const TimerStarted({required this.duration});
  final int duration;

  @override
  List<Object> get props => [duration];
}

class TimerPaused extends TimerEvent {
  const TimerPaused();
}

class TimerResumed extends TimerEvent {
  const TimerResumed();
}

class TimerReset extends TimerEvent {
  const TimerReset();
}

class TimerStopped extends TimerEvent {
  const TimerStopped();
}

class TimerTicked extends TimerEvent {
  const TimerTicked({
    required this.duration,
  });
  final int duration;

  @override
  List<Object> get props => [duration];
}
