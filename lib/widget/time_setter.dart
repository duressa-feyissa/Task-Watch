import 'package:flutter/material.dart';

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
