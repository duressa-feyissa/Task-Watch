import 'dart:async';

import 'package:bloc_mastering/Bloc/Timerbloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerDisplay extends StatefulWidget {
  const TimerDisplay({
    super.key,
  });

  @override
  State<TimerDisplay> createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay> {
  late StreamSubscription<int> _currentTimeSubscription;
  int duration = 0;

  @override
  void initState() {
    super.initState();
    _currentTimeSubscription =
        context.read<TimerBloc>().timerDataStream.listen((currentTime) {
      setState(() {
        duration = currentTime;
      });
    });
  }

  @override
  void dispose() {
    _currentTimeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    duration = context.watch<TimerBloc>().state.duration;
    var hoursStr = (duration ~/ 3600).toString().padLeft(2, '0');
    var minutesStr = ((duration ~/ 60) % 60).toString().padLeft(2, '0');
    var secondsStr = (duration % 60).toString().padLeft(2, '0');

    var timeText = '$hoursStr:$minutesStr:$secondsStr';

    return Center(
      child: ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Color.fromARGB(255, 0, 69, 104),
            ],
          ).createShader(bounds);
        },
        child: Text(
          timeText,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
