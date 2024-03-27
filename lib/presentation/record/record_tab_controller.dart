import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screen_recording/flutter_screen_recording.dart';
import 'package:open_file/open_file.dart';
import 'package:pointycastle/block/aes.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'components/recording_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

final resolutionProvider = StateProvider.autoDispose((ref) {
  return RecordingResolution.medium;
});
final frameRateProvider = StateProvider.autoDispose((ref) {
  return 30;
});
final bitrateProvider = StateProvider.autoDispose((ref) {
  return Bitrate.low;
});
final orientationProvider = StateProvider.autoDispose((ref) {
  return RecordingOrientation.portrait;
});

final timerProvider =
    StateProvider.autoDispose<Duration>((ref) => Duration.zero);

final isTimerStoppedProvider = StateProvider.autoDispose<bool>((ref) => true);

class TimerService {
  TimerService._();
  static final instance = TimerService._();
  Timer? _timer;

  void startTimer(WidgetRef ref) {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        ref.read(timerProvider.notifier).state += const Duration(seconds: 1);
      },
    );
  }

  void stopTimer(WidgetRef ref) {
    _timer?.cancel();
    ref.read(isTimerStoppedProvider.notifier).update((state) => true);
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    seconds = seconds % 60;

    String formattedTime =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return formattedTime;
  }
}

startScreenRecord() async {
  await FlutterScreenRecording.startRecordScreenAndAudio("Title");
}

// final thumbnailProvider = StateProvider.autoDispose<Uint8List>((ref) {
//   return Uint8List;
// });
// stopScreenRecord(WidgetRef ref) async {
//   String path = await FlutterScreenRecording.stopRecordScreen;
//   print(path);

//   // ref.read(pathProvider.notifier).update((state) => path);

//   // writeRecordingToAppDocuments(path);
//   // await saveVideo(path, "${DateTime.now()}.mp4", false);
//   // OpenFile.open(path);
// }

Future<String> writeRecordingToAppDocuments(String videoPath) async {
  final appDocumentsDirectory = await getApplicationDocumentsDirectory();
  final fileName = path.basename(videoPath);
  final destinationPath = path.join(appDocumentsDirectory.path, fileName);

  final file = File(videoPath);
  await file.copy(destinationPath);

  return destinationPath;
}

stopScreenRecord(WidgetRef ref) async {
  String videoPath = await FlutterScreenRecording.stopRecordScreen;

  OpenFile.open(videoPath);

  // final savedPath = await writeRecordingToAppDocuments(videoPath);
  // print(savedPath);
  // Now the video is saved in the app's documents directory
  // savedPath can be used to retrieve the video later
}

final pathProvider = StateProvider.autoDispose((ref) {
  return "/storage/emulated/0/Android/data/com.example.pavega_assignment/cache/Title.mp4";
});

genThumbnail(WidgetRef ref) async {
  final uint8list = await VideoThumbnail.thumbnailData(
    video: ref.read(pathProvider),
    imageFormat: ImageFormat.JPEG,
    maxWidth: 128,
    quality: 100,
  );

  return uint8list;
}

requestPermissions() async {
  if (await Permission.storage.request().isDenied) {
    await Permission.storage.request();
  }
  if (await Permission.photos.request().isDenied) {
    await Permission.photos.request();
  }
  if (await Permission.microphone.request().isDenied) {
    await Permission.microphone.request();
  }
  if (await Permission.storage.request().isDenied) {
    await Permission.storage.request();
  }
  if (await Permission.manageExternalStorage.request().isDenied) {
    await Permission.manageExternalStorage.request();
  }
}

String generateUniqueFileName() {
  final timestamp = DateTime.now().toString().replaceAll(".", "");
  return "recording_$timestamp.mp4";
}

// Future<void> writeRecordingToAppDocuments(String recordedVideoPath) async {
//   final appDirectory = await getApplicationDocumentsDirectory();
//   final fileName = generateUniqueFileName();
//   final newFilePath = "${appDirectory.path}/$fileName";

//   // Read the recorded video data
//   final bytes = await File(recordedVideoPath).readAsBytes();

//   // Write the data to the new file in application documents directory
//   await File(newFilePath).writeAsBytes(bytes);
// }

Future<String> createRecordingsFolder() async {
  // 1. Get the app storage directory
  final appDirectory = await getApplicationDocumentsDirectory();

  // 2. Define the recordings folder name
  const recordingsFolderName = 'recordings';

  // 3. Check if the folder already exists
  final recordingsDirectory =
      Directory('${appDirectory.path}/$recordingsFolderName');
  final doesExist = await recordingsDirectory.exists();

  // 4. Create the folder if it doesn't exist
  if (!doesExist) {
    await recordingsDirectory.create(recursive: true);
  }

  // 5. Return the path to the recordings folder
  return recordingsDirectory.path;
}

Future<void> saveVideo(
    String videoData, String filename, bool isEncrypted) async {
  final recordingsFolderPath = await createRecordingsFolder();
  final filePath = '$recordingsFolderPath/$filename';

  final videoFile = File(filePath);

  // Write the video data to the file
  if (isEncrypted) {
    // Placeholder for encryption logic using pointycastle
    final encryptedData = await _encryptVideo(videoData);
    await videoFile.writeAsBytes(encryptedData);
  } else {
    await videoFile.writeAsString(videoData);
  }

  print('Video saved to: $filePath');
}

// Placeholder function for encryption logic (replace with your actual implementation)
Future<Uint8List> _encryptVideo(String videoData) async {
  // 1. Generate a random key (replace with secure key generation)
  final key = Random.secure().nextInt(32) as Uint8List;

  // 2. Create a CipherParameters object (replace with chosen algorithm)
  final params = KeyParameter(key);

  // 3. Create a block cipher (replace with chosen algorithm)
  final cipher = AESEngine();

  // 4. Initialize the cipher for encryption
  cipher.init(true, params);

  // 5. Convert video data to bytes
  final videoBytes = utf8.encode(videoData);

  // 6. Placeholder for actual encryption (replace with pointycastle functions)
  final encryptedBytes =
      cipher.process(videoBytes); // Replace with actual encryption logic

  // 7. Return the encrypted byte array
  return encryptedBytes;
}

// Future<void> _insertVideoToStorage() async {
//   // Check and request storage permission if not granted
//   var status = await Permission.storage.status;
//   if (!status.isGranted) {
//     await Permission.storage.request();
//   }

//   // Get external storage directory
//   Directory storageDirectory = await getExternalStorageDirectory();
//   String storagePath = storageDirectory.path;

//   // Copy video file from assets to external storage
//   ByteData data = await rootBundle.load('assets/$videoFileName');
//   List<int> bytes = data.buffer.asUint8List();
//   File videoFile = File('$storagePath/$videoFileName');
//   await videoFile.writeAsBytes(bytes);

//   // Show message after video insertion
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     content: Text('Video inserted to phone storage'),
//   ));
// }
