import 'package:bloc_mastering/Bloc/Timerbloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerActions extends StatelessWidget {
  const TimerActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (context.watch<TimerBloc>().state.status == TimerStatus.running)
          GestureDetector(
            onTap: () {
              context.read<TimerBloc>().add(const TimerPaused());
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 69, 104),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(Icons.pause, color: Colors.white),
            ),
          ),
        if (context.watch<TimerBloc>().state.status == TimerStatus.paused)
          GestureDetector(
            onTap: () {
              context.read<TimerBloc>().add(const TimerResumed());
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 69, 104),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(Icons.play_arrow, color: Colors.white),
            ),
          ),
        if (context.watch<TimerBloc>().state.status == TimerStatus.paused ||
            context.watch<TimerBloc>().state.status == TimerStatus.running)
          GestureDetector(
            onTap: () {
              context.read<TimerBloc>().add(const TimerStopped());
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 69, 104),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(Icons.stop, color: Colors.white),
            ),
          ),
        if (context.watch<TimerBloc>().state.status == TimerStatus.finished)
          GestureDetector(
            onTap: () {
              context.read<TimerBloc>().add(const TimerReset());
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 69, 104),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(Icons.replay, color: Colors.white),
            ),
          ),
      ],
    );
  }
}
