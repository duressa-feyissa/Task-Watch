import 'dart:async';
import 'dart:math' as math;

import 'package:bloc_mastering/Timerbloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularTimerWidget(),
        SizedBox(height: 32),
        Text('Timer'),
      ],
    );
  }
}

class CircularTimerWidget extends StatefulWidget {
  const CircularTimerWidget({
    super.key,
  });

  @override
  State<CircularTimerWidget> createState() => _CircularTimerWidgetState();
}

class _CircularTimerWidgetState extends State<CircularTimerWidget> {
  late StreamSubscription<int> _currentTimeSubscription;
  int _currentTime = 0;

  @override
  void initState() {
    super.initState();

    _currentTimeSubscription =
        context.read<TimerBloc>().timerDataStream.listen((currentTime) {
      setState(() {
        _currentTime = currentTime;
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
    var duration = _currentTime;

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
            progress: 89,
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 120, 212, 255),
                Color.fromARGB(255, 24, 119, 167),
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

class CircularTimerPainter extends CustomPainter {
  final BuildContext context;
  final double progress;
  final Gradient gradient;

  CircularTimerPainter({
    required this.progress,
    required this.gradient,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2.0;

    final Paint backgroundPaint = Paint()
      ..color = const Color.fromARGB(255, 143, 144, 182).withOpacity(0.2)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20.0
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, backgroundPaint);

    final Paint fillPaint = Paint()
      ..shader =
          gradient.createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20.0
      ..style = PaintingStyle.stroke;

    final double arcAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      arcAngle,
      false,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
