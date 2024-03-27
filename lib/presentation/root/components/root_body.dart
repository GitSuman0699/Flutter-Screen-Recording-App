import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pavega_assignment/presentation/root/components/tab_bar_view_widget.dart';
import 'package:pavega_assignment/utils/constants/colors.dart';
import 'package:pavega_assignment/utils/constants/font_styles.dart';
import 'package:pavega_assignment/utils/theme/theme.dart';

import 'tab_bar_widget.dart';

class RootBody extends ConsumerStatefulWidget {
  const RootBody({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RootBodyState();
}

class _RootBodyState extends ConsumerState<RootBody>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeNotifierProvider) == Brightness.dark;
    return SafeArea(
      top: false,
      child: Container(
        color: isDark ? kDarkTextFieldBgColor : kPrimaryColor,
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 13,
                    ),
                    const Icon(
                      Icons.video_chat_rounded,
                      size: 31,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Screen Recorder",
                      style: FontStyles.montserratBold25(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: ThemeToggle(ref: ref),
                )
              ],
            ),
            TabBarWidget(tabController: _tabController),
            const SizedBox(height: 20),
            TabBarViewWidget(tabController: _tabController),
          ],
        ),
      ),
    );
  }
}
