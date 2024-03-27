import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pavega_assignment/presentation/record/record_tab_controller.dart';

class TimerWidget extends ConsumerWidget {
  const TimerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          TimerService.instance.formatTime(ref.watch(timerProvider).inSeconds),
          style: TextStyle(
            fontSize: 30,
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
