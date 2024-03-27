import 'package:bloc_mastering/Bloc/Timerbloc/timer_bloc.dart';
import 'package:bloc_mastering/widget/time_setter.dart';
import 'package:bloc_mastering/widget/timer_controller.dart';
import 'package:bloc_mastering/widget/timer_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Timer extends StatelessWidget {
  Timer({super.key});

  final TextEditingController _time = TextEditingController(text: '5');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (context.watch<TimerBloc>().state.status == TimerStatus.initial)
          Column(
            children: [
              const Text(
                'Set the Timer',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 0, 69, 104),
                ),
              ),
              const SizedBox(height: 50),
              TimeSetter(timeController: _time),
              const SizedBox(height: 64),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 69, 104),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                onPressed: () {
                  context.read<TimerBloc>().add(
                        TimerStarted(
                          duration: int.tryParse(_time.text) ?? 0,
                        ),
                      );
                },
                child: Container(
                  width: 100,
                  height: 55,
                  alignment: Alignment.center,
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        if (context.watch<TimerBloc>().state.status != TimerStatus.initial)
          const Column(
            children: [
              TimerDisplay(),
              SizedBox(height: 40),
              TimerActions(),
            ],
          ),
      ],
    );
  }
}
