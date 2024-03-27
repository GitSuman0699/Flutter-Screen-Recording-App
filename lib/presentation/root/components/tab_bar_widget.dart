import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorPadding: const EdgeInsets.fromLTRB(-16, 8, -16, 8),
      controller: _tabController,
      tabs: const [
        Tab(
          text: "Record",
        ),
        Tab(
          text: "Recordings",
        ),
      ],
    );
  }
}
