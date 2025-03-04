import 'package:roquu_assessement_test/models/trade_model.dart';

abstract class TradesEvent {}

class LoadTrades extends TradesEvent {
  final String symbol;

  LoadTrades({required this.symbol});
}

class UpdateTrades extends TradesEvent {
  final TradeModel trade;

  UpdateTrades({required this.trade});
}