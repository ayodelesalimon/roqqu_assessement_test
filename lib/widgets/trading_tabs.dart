import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/theme/theme_bloc.dart';
import '../blocs/theme/theme_state.dart';
import 'chart_widget.dart';
import 'orderbook_widget.dart';
import 'recent_trade_widget.dart';

class TradingTabs extends StatefulWidget {
  const TradingTabs({Key? key}) : super(key: key);

  @override
  State<TradingTabs> createState() => _TradingTabsState();
}

class _TradingTabsState extends State<TradingTabs>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<String> titles = ["Charts", "Orderbook", "Recent trades"];
  final List<Widget> pages = const [
    ChartWidget(),
    OrderbookWidget(),
    RecentTradesWidget(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: titles.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      final isDarkMode = themeState.themeMode == ThemeModes.dark;

      return Column(
        children: [
          _buildCustomTabBar(isDarkMode),
          Expanded(
              child: TabBarView(controller: _tabController, children: pages)),
        ],
      );
    });
  }

  Widget _buildCustomTabBar(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        // Background color based on theme
        color: isDarkMode
            ? Theme.of(context).colorScheme.surface
            : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(titles.length, (index) {
          final isSelected = _tabController.index == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _tabController.index = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(vertical: 12),
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDarkMode ? Colors.black : Colors.white)
                      : (isDarkMode
                          ? Theme.of(context).colorScheme.surface
                          : Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected && !isDarkMode
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  titles[index],
                  style: TextStyle(
                    color: isSelected
                        ? (isDarkMode ? Colors.white : Colors.black)
                        : Colors.grey,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
