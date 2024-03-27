import 'dart:async';

import 'package:bloc_mastering/Bloc/Timerbloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'circular_timer_painter.dart';

class CircularTimerWidget extends StatefulWidget {
  final int second;
  const CircularTimerWidget({
    super.key,
    required this.second,
  });

  @override
  State<CircularTimerWidget> createState() => _CircularTimerWidgetState();
}

class _CircularTimerWidgetState extends State<CircularTimerWidget> {
  late StreamSubscription<int> _currentTimeSubscription;
  int duration = 0;

  @override
  void initState() {
    super.initState();
    duration = widget.second;
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
    var hoursStr = (duration ~/ 3600).toString().padLeft(2, '0');
    var minutesStr = ((duration ~/ 60) % 60).toString().padLeft(2, '0');
    var secondsStr = (duration % 60).toString().padLeft(2, '0');

    var timeText = '$hoursStr:$minutesStr:$secondsStr';

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.45,
        height: MediaQuery.of(context).size.width * 0.45,
        child: CustomPaint(
          painter: CircularTimerPainter(
            context: context,
            progress: duration / widget.second,
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 92, 182, 224),
                Color.fromARGB(255, 0, 69, 104),
              ],
              stops: [0.0, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Text(
              timeText,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 0, 69, 104),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
