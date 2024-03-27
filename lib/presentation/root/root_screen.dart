import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pavega_assignment/utils/constants/font_styles.dart';
import 'package:pavega_assignment/utils/theme/theme.dart';
import 'components/root_body.dart';

class RootScreen extends ConsumerWidget {
  const RootScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      // appBar: AppBar(
      //   titleSpacing: 0.0,
      //   leading: const Icon(
      //     Icons.video_chat_rounded,
      //     size: 30,
      //   ),
      //   title: Text(
      //     "Screen Recorder",
      //     style: FontStyles.montserratBold25(),
      //   ),
      //   actions: [ThemeToggle(ref: ref)],
      // ),
      body: RootBody(),
    );
  }
}
