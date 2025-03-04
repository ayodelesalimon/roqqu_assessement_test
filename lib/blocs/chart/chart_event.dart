import '../../models/candle_stick_model.dart';

abstract class ChartEvent {}

class LoadChartData extends ChartEvent {
  final String symbol;
  final String interval;

  LoadChartData({required this.symbol, required this.interval});
}

class UpdateChartData extends ChartEvent {
  final CandlestickModel candlestick;

  UpdateChartData({required this.candlestick});
}
