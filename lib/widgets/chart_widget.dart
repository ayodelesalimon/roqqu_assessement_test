import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:candlesticks/candlesticks.dart';

import '../blocs/chart/chart_bloc.dart';
import '../blocs/chart/chart_state.dart';
import '../blocs/theme/theme_bloc.dart';
import '../blocs/theme/theme_state.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({Key? key}) : super(key: key);

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState.themeMode == ThemeModes.dark;

        return Column(
          children: [
            _buildTimeIntervalSelector(isDarkMode),
            _buildChartControls(isDarkMode),
            Expanded(
              child: BlocBuilder<ChartBloc, ChartState>(
                builder: (context, state) {
                  if (state is ChartLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  } else if (state is ChartLoaded) {
                    if (state.candlesticks.isEmpty) {
                      return Center(
                        child: Text(
                          'No data available',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      );
                    }
                    final candles = state.candlesticks
                        .map((e) => Candle(
                              date: e.timestamp,
                              high: e.high,
                              low: e.low,
                              open: e.open,
                              close: e.close,
                              volume: e.volume,
                            ))
                        .toList();

                    return Candlesticks(
                      candles: candles,
                      // Set up optimal UI colors based on theme
                      // primaryColor: Theme.of(context).primaryColor,
                      // // If candlesticks package supports theme customization:
                      // // For light mode, we might want to adjust background color:
                      // backgroundColor: isDarkMode
                      //     ? const Color(0xFF151B22) // Dark background
                      //     : Colors.white, // Light background
                      // // onIntervalChange: (String interval) {
                      // //   // Handle interval change
                      // // },
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Error loading chart data',
                        style: TextStyle(
                          color: isDarkMode
                              ? Colors.red.shade300
                              : Colors.red.shade700,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTimeIntervalSelector(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          _buildTimeButton('1H', isSelected: false, isDarkMode: isDarkMode),
          _buildTimeButton('2H', isSelected: false, isDarkMode: isDarkMode),
          _buildTimeButton('4H', isSelected: false, isDarkMode: isDarkMode),
          _buildTimeButton('1D', isSelected: true, isDarkMode: isDarkMode),
          _buildTimeButton('1W', isSelected: false, isDarkMode: isDarkMode),
          _buildTimeButton('1M', isSelected: false, isDarkMode: isDarkMode),
        ],
      ),
    );
  }

  Widget _buildTimeButton(
    String text, {
    required bool isSelected,
    required bool isDarkMode,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Material(
        color: isSelected
            ? Theme.of(context).primaryColor.withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              text,
              style: TextStyle(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : (isDarkMode ? Colors.white : Colors.black87),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChartControls(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildControlButton('Trading view',
                  isSelected: true, isDarkMode: isDarkMode),
              _buildControlButton('Depth',
                  isSelected: false, isDarkMode: isDarkMode),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(
    String text, {
    required bool isSelected,
    required bool isDarkMode,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Material(
        color: isSelected
            ? Theme.of(context).colorScheme.background
            : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // Handle view change
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              text,
              style: TextStyle(
                color: isSelected
                    ? (isDarkMode ? Colors.white : Colors.black87)
                    : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
