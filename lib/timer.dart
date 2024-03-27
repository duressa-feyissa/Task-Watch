import 'dart:async';
import 'dart:math' as math;

import 'package:bloc_mastering/Timerbloc/timer_bloc.dart';
import 'package:bloc_mastering/timer_controller.dart';
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
          Column(
            children: [
              CircularTimerWidget(second: int.tryParse(_time.text) ?? 0),
              const SizedBox(height: 64),
              const TimerActions(),
            ],
          ),
      ],
    );
  }
}

class TimeSetter extends StatelessWidget {
  final TextEditingController timeController;

  const TimeSetter({super.key, required this.timeController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_drop_up,
            size: 60,
            color: Color.fromARGB(255, 0, 69, 104),
          ),
          onPressed: () {
            int currentTime = int.tryParse(timeController.text) ?? 0;
            timeController.text = (currentTime + 1).toString();
          },
        ),
        const SizedBox(width: 32),
        SizedBox(
          width: 80,
          child: TextField(
            controller: timeController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              focusColor: Color.fromARGB(255, 0, 69, 104),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
        IconButton(
          icon: const Icon(Icons.arrow_drop_down,
              size: 60, color: Color.fromARGB(255, 0, 69, 104)),
          onPressed: () {
            int currentTime = int.tryParse(timeController.text) ?? 0;
            if (currentTime > 0) {
              timeController.text = (currentTime - 1).toString();
            }
          },
        ),
      ],
    );
  }
}

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
