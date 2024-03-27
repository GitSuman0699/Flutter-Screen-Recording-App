import 'package:flutter/widgets.dart';

class RecordingSettingRow extends StatelessWidget {
  final List<Widget> rowWidgets;
  const RecordingSettingRow({
    Key? key,
    required this.rowWidgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: rowWidgets,
    );
  }
}
