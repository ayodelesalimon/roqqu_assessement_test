import '../../models/trade_model.dart';

abstract class TradesState {}

class TradesInitial extends TradesState {}

class TradesLoading extends TradesState {}

class TradesLoaded extends TradesState {
  final List<TradeModel> trades;

  TradesLoaded({required this.trades});
}

class TradesError extends TradesState {
  final String message;

  TradesError({required this.message});
}