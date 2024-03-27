import 'package:flutter/material.dart';
import 'package:pavega_assignment/utils/constants/font_styles.dart';

class RecordingSettingWidget extends StatelessWidget {
  final String settingName;
  final Widget dropDownWidget;
  const RecordingSettingWidget({
    Key? key,
    required this.settingName,
    required this.dropDownWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          settingName,
          style: FontStyles.montserratBold11(),
        ),
        dropDownWidget,
      ],
    );
  }
}
