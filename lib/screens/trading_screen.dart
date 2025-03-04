import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants.dart';
import '../../../../injection_container.dart';
import '../blocs/chart/chart_bloc.dart';
import '../blocs/chart/chart_event.dart';
import '../blocs/orderbook/orderbook_bloc.dart';
import '../blocs/orderbook/orderbook_event.dart';
import '../blocs/trade/trade_bloc.dart';
import '../blocs/trade/trade_event.dart';
import '../widgets/trading_header.dart';
import '../widgets/trading_tabs.dart';

class TradingPage extends StatefulWidget {
  const TradingPage({Key? key}) : super(key: key);

  @override
  State<TradingPage> createState() => _TradingPageState();
}

class _TradingPageState extends State<TradingPage> {
  final String symbol = ApiConstants.defaultSymbol;
  final String interval = ApiConstants.defaultTimeframe;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChartBloc>(
          create: (context) => sl<ChartBloc>()
            ..add(LoadChartData(symbol: symbol, interval: interval)),
        ),
        BlocProvider<OrderbookBloc>(
          create: (context) =>
              sl<OrderbookBloc>()..add(LoadOrderbook(symbol: symbol)),
        ),
        BlocProvider<TradesBloc>(
          create: (context) =>
              sl<TradesBloc>()..add(LoadTrades(symbol: symbol)),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const TradingHeader(),
              Expanded(
                child: Row(
                  children: [
           
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: const [
                          Expanded(child: TradingTabs()),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
