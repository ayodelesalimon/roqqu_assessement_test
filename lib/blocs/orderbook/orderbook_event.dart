import '../../models/orderbook_entry_model.dart';

abstract class OrderbookEvent {}

class LoadOrderbook extends OrderbookEvent {
  final String symbol;

  LoadOrderbook({required this.symbol});
}

class UpdateOrderbook extends OrderbookEvent {
  final OrderbookModel orderbook;

  UpdateOrderbook({required this.orderbook});
}