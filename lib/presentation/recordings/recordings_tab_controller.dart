import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pavega_assignment/presentation/record/record_tab_controller.dart';

final getRecordingsListProvider = FutureProvider.autoDispose((ref) async {
  final recordingsFolderPath = await getApplicationDocumentsDirectory();
  final recordingsDirectory = Directory(recordingsFolderPath.path);
  final recordings =
      recordingsDirectory.listSync(recursive: true, followLinks: false);
  return recordings.whereType<File>().map((f) => f.path).toList();
});
