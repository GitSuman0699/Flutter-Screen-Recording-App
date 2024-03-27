import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pavega_assignment/presentation/root/root_screen.dart';
import 'package:pavega_assignment/utils/theme/theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider);

    return MaterialApp(
      title: 'Screen Recording App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode:
          themeNotifier == Brightness.light ? ThemeMode.light : ThemeMode.dark,
      home: const RootScreen(),
    );
  }
}
