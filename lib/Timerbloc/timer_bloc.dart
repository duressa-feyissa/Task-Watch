import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_mastering/ticker.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  TimerBloc({
    required Ticker ticker,
  })  : _ticker = ticker,
        super(TimerState(status: TimerStatus.initial)) {}
  final _timerDataController = StreamController<int>.broadcast();
  Stream<int> get timerDataStream => _timerDataController.stream;
}
