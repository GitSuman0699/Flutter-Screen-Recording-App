import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pavega_assignment/presentation/recordings/recordings_tab_controller.dart';
import 'package:pavega_assignment/presentation/recordings/video_player.dart';

class RecordingsTab extends ConsumerStatefulWidget {
  const RecordingsTab({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecordingsTabState();
}

class _RecordingsTabState extends ConsumerState<RecordingsTab> {
  @override
  Widget build(BuildContext context) {
    final recordingsList = ref.watch(getRecordingsListProvider);
    return recordingsList.when(
      error: (error, stackTrace) => ErrorWidget(error),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (data) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            data.isEmpty
                ? ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const VideoApp(),
                      //     ));
                    },
                    child: const Text("GO"))
                : const Text("List"),
          ],
        ),
      ),
    );
  }
}
