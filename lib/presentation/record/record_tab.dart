import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pavega_assignment/presentation/record/components/timer_widget.dart';
import 'package:pavega_assignment/utils/theme/theme.dart';
import 'package:video_player/video_player.dart';
import 'components/bottom_sheet.dart';
import 'record_tab_controller.dart';

class RecordTab extends ConsumerStatefulWidget {
  const RecordTab({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecordTabState();
}

class _RecordTabState extends ConsumerState<RecordTab> {
  Uint8List? thumbnail;

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeNotifierProvider) == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const TimerWidget(),
          const SizedBox(height: 100),
          // thumbnailProvider
          thumbnail != null
              ? Image.memory(
                  thumbnail!,
                  height: 80,
                  width: 80,
                  errorBuilder: (context, error, stackTrace) {
                    return Text(
                      "This image is no longer available.",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: isDark ? Colors.grey : Colors.grey[600]),
                    );
                  },
                  fit: BoxFit.fill,
                )
              : const SizedBox.shrink(),
          Center(
            child: GestureDetector(
              onTap: () async {
                if (ref.read(isTimerStoppedProvider)) {
                  ref
                      .read(timerProvider.notifier)
                      .update((state) => Duration.zero);
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SettingsBottomSheet(
                        ref: ref,
                        isDark: isDark,
                      );
                    },
                  );
                } else {
                  await stopScreenRecord(ref);

                  TimerService.instance.stopTimer(ref);
                }
              },
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(80),
                    ),
                    color: isDark ? kDarkTextFieldBgColor : kPrimaryColor),
                child: Center(
                  child: Text(
                    ref.watch(isTimerStoppedProvider) ? "START" : "STOP",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// class RecordTab extends StatefulWidget {
//   const RecordTab({super.key});

//   @override
//   State<RecordTab> createState() => _RecordTabState();
// }

// class _RecordTabState extends State<RecordTab> {
 
// }
