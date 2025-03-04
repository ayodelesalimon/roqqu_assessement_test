import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/orderbook/orderbook_bloc.dart';
import '../blocs/orderbook/orderbook_state.dart';
import '../models/orderbook_entry_model.dart';
import 'trading_form.dart';

class OrderbookWidget extends StatelessWidget {
  const OrderbookWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildOrderbookHeader(),
        Expanded(
          child: BlocBuilder<OrderbookBloc, OrderbookState>(
            builder: (context, state) {
              if (state is OrderbookLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is OrderbookLoaded) {
                return _buildOrderbook(context, state.orderbook);
              } else {
                return const Center(child: Text('Error loading orderbook'));
              }
            },
          ),
        ),
        _buildBottomButtons(context),
      ],
    );
  }

  Widget _buildOrderbookHeader() {
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
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                const Icon(Icons.format_list_bulleted,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                const Text(
                  'Price',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const Text(
                  ' (USDT)',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: const [
                Icon(Icons.bar_chart, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Amounts',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  ' (BTC)',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 2,
            child: Text(
              'Total',
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

  Widget _buildOrderbook(BuildContext context, OrderbookModel orderbook) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: orderbook.asks.length,
                  itemBuilder: (context, index) => _buildOrderRow(
                    context,
                    orderbook.asks[index],
                    isBuy: false,
                    maxQuantity: _getMaxQuantity(orderbook.asks),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: Colors.grey.shade800,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '36,641.20',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_upward,
                      color: Theme.of(context).primaryColor,
                      size: 14,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: orderbook.bids.length,
                  itemBuilder: (context, index) => _buildOrderRow(
                    context,
                    orderbook.bids[index],
                    isBuy: true,
                    maxQuantity: _getMaxQuantity(orderbook.bids),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double _getMaxQuantity(List<OrderbookEntry> entries) {
    if (entries.isEmpty) return 1.0;
    return entries.map((e) => e.quantity).reduce((a, b) => a > b ? a : b);
  }

  Widget _buildOrderRow(BuildContext context, OrderbookEntry entry,
      {required bool isBuy, required double maxQuantity}) {
    final percentFilled = entry.quantity / maxQuantity;
    final backgroundColor = isBuy
        ? Theme.of(context).primaryColor.withOpacity(0.1 * percentFilled)
        : Theme.of(context)
            .colorScheme
            .secondary
            .withOpacity(0.1 * percentFilled);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              entry.price.toStringAsFixed(2),
              style: TextStyle(
                color: isBuy
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              entry.quantity.toStringAsFixed(6),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              (entry.price * entry.quantity).toStringAsFixed(2),
              style: const TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 4),
              ),
              onPressed: () {
                TradingBottomSheet.show(context);
              },
              child: const Text('Buy'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 2),
              ),
              onPressed: () {},
              child: const Text('Sell'),
            ),
          ),
        ],
      ),
    );
  }
}
