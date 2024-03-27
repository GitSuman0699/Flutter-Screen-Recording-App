import 'package:flutter/material.dart';
import 'package:pavega_assignment/utils/theme/theme.dart';

class DropDownContainer extends StatelessWidget {
  final Widget dropDownWidget;
  final bool isDark;
  const DropDownContainer({
    Key? key,
    required this.dropDownWidget,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width / 2.4,
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: isDark ? kDarkTextFieldBgColor : kPrimaryColor,
      ),
      child: dropDownWidget,
    );
  }
}
