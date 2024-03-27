import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_mastering/Model/ticker.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({
    required Ticker ticker,
  })  : _ticker = ticker,
        super(TimerState(status: TimerStatus.initial)) {
    on<TimerStarted>(_onStarted);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
    on<TimerTicked>(_onTicked);
    on<TimerStopped>(_onStopped);
  }

  final Ticker _ticker;
  final _timerDataController = StreamController<int>.broadcast();
  Stream<int> get timerDataStream => _timerDataController.stream;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    _timerDataController.close();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    _timerDataController.add(event.duration);
    emit(state.copyWith(
      duration: event.duration,
      status: TimerStatus.running,
      length: event.duration,
    ));

    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state.status == TimerStatus.running) {
      _tickerSubscription?.pause();
      emit(state.copyWith(status: TimerStatus.paused));
    }
  }

  void _onResumed(TimerResumed resume, Emitter<TimerState> emit) {
    if (state.status == TimerStatus.paused) {
      _tickerSubscription?.resume();
      emit(state.copyWith(status: TimerStatus.running));
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    emit(state.copyWith(
      duration: state.length,
      status: TimerStatus.running,
    ));

    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: state.length)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  void _onStopped(TimerStopped event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(TimerState(status: TimerStatus.initial));
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    if (event.duration == 0) {
      emit(TimerState(
          duration: 0, status: TimerStatus.finished, length: state.length));
    } else {
      state.duration = event.duration;
    }
    _timerDataController.add(event.duration);
  }
}
