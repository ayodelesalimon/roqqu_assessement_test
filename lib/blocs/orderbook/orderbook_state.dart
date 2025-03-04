import '../../models/orderbook_entry_model.dart';

abstract class OrderbookState {}

class OrderbookInitial extends OrderbookState {}

class OrderbookLoading extends OrderbookState {}

class OrderbookLoaded extends OrderbookState {
  final OrderbookModel orderbook;

  OrderbookLoaded({required this.orderbook});
}

class OrderbookError extends OrderbookState {
  final String message;

  OrderbookError({required this.message});
}