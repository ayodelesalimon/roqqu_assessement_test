import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/trade/trade_bloc.dart';
import '../blocs/trade/trade_state.dart';
import '../models/trade_model.dart';


class RecentTradesWidget extends StatelessWidget {
  const RecentTradesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTradesHeader(),
        Expanded(
          child: BlocBuilder<TradesBloc, TradesState>(
            builder: (context, state) {
              if (state is TradesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TradesLoaded) {
                if (state.trades.isEmpty) {
                  return const Center(child: Text('No recent trades'));
                }
                return ListView.builder(
                  itemCount: state.trades.length,
                  itemBuilder: (context, index) => _buildTradeRow(
                    context,
                    state.trades[index],
                  ),
                );
              } else {
                return const Center(child: Text('Error loading trades'));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTradesHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade800,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: const [
          Expanded(
            flex: 3,
            child: Text(
              'Price (USDT)',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Amount (BTC)',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Time',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTradeRow(BuildContext context, TradeModel trade) {
    final timeFormat = DateFormat('HH:mm:ss');
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade800.withOpacity(0.5),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              trade.price.toStringAsFixed(2),
              style: TextStyle(
                color: trade.isBuyerMaker
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).primaryColor,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              trade.quantity.toStringAsFixed(6),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              timeFormat.format(trade.time),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}