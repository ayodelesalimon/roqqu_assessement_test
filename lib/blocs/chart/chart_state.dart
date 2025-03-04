import '../../models/candle_stick_model.dart';

abstract class ChartState {}

class ChartInitial extends ChartState {}

class ChartLoading extends ChartState {}

class ChartLoaded extends ChartState {
  final List<CandlestickModel> candlesticks;
  final String interval;

  ChartLoaded({required this.candlesticks, required this.interval});
}

class ChartError extends ChartState {
  final String message;

  ChartError({required this.message});
}
