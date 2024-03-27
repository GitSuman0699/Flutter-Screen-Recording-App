import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeNotifierProvider =
    StateNotifierProvider.autoDispose<ThemeNotifier, Brightness>(
  (ref) => ThemeNotifier(),
  name: (ThemeNotifier).toString(),
);

class ThemeNotifier extends StateNotifier<Brightness> {
  ThemeNotifier() : super(_systemBrightness);

  static Brightness get _systemBrightness {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness;
  }

  void toggle() {
    state = state == Brightness.dark ? Brightness.light : Brightness.dark;
  }
}

const kPrimaryColor = Color.fromRGBO(20, 108, 97, 1);
const kDarkBgColor = Color.fromRGBO(19, 28, 33, 1);
const kLightBgColor = Color.fromRGBO(255, 255, 255, 1);
const kTextHighlightColor = Color.fromRGBO(58, 113, 253, 1);
const kDarkAppBarColor = Color.fromRGBO(31, 44, 52, 1);
const kUnselectedLabelColor = Color.fromRGBO(190, 196, 201, 1);
const kReceiverMessageColorDark = Color.fromRGBO(37, 45, 49, 1);
const kSenderMessageColorDark = Color.fromRGBO(5, 96, 98, 1);
const kSenderMessageColorLight = Color.fromRGBO(215, 251, 211, 1);
const kDarkTextFieldBgColor = Color.fromRGBO(37, 45, 49, 1);
const kLightTextFieldBgColor = Color.fromRGBO(245, 245, 245, 1);
const kReplyMessageColor = Color.fromRGBO(31, 37, 40, 1);

final lightTheme = ThemeData.light().copyWith(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: kPrimaryColor,
  ),
  scaffoldBackgroundColor: kLightBgColor,
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    color: kPrimaryColor,
    foregroundColor: Colors.white,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.white,
    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
    dividerHeight: 0,
    unselectedLabelColor: Colors.grey[400],
    indicatorColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 1.0,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      shape: CircleBorder()),
);

final darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: kDarkBgColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: kPrimaryColor,
    brightness: Brightness.dark,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.white,
    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
    dividerHeight: 0,
    unselectedLabelColor: Colors.grey[400],
    indicatorColor: Colors.white,
  ),
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    color: kDarkAppBarColor,
    foregroundColor: Colors.white,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: kDarkBgColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 1.0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
    ),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: kDarkTextFieldBgColor,
    contentTextStyle: TextStyle(color: Colors.white),
  ),
  // set underline text field color same as kPrimaryColor
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      shape: CircleBorder()),
);

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({
    Key? key,
    required this.ref,
  }) : super(key: key);

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: ref.watch(themeNotifierProvider) == Brightness.dark ? true : false,
      onChanged: (value) {
        ref.watch(themeNotifierProvider.notifier).toggle();
      },
    );
  }
}
