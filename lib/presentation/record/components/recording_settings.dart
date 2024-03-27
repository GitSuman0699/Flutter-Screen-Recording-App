class RecordingSetting {
  final RecordingResolution resolution;
  final int frameRate;
  final int bitrate;
  final RecordingOrientation orientation;

  RecordingSetting({
    required this.resolution,
    required this.frameRate,
    required this.bitrate,
    required this.orientation,
  });
}

enum RecordingResolution {
  low,
  medium,
  high,
}

enum Bitrate {
  low,
  medium,
  high,
}

enum RecordingOrientation {
  portrait,
  landscape,
}

String resolutionToString(RecordingResolution resolution) {
  switch (resolution) {
    case RecordingResolution.low:
      return 'Low';
    case RecordingResolution.medium:
      return 'Medium';
    case RecordingResolution.high:
      return 'High';
    default:
      return 'Unknown';
  }
}

String bitrateToString(Bitrate resolution) {
  switch (resolution) {
    case Bitrate.low:
      return 'Low';
    case Bitrate.medium:
      return 'Medium';
    case Bitrate.high:
      return 'High';
    default:
      return 'Unknown';
  }
}

String orientationToString(RecordingOrientation orientation) {
  switch (orientation) {
    case RecordingOrientation.portrait:
      return 'Portrait';
    case RecordingOrientation.landscape:
      return 'Landscape';
    default:
      return 'Unknown';
  }
}
