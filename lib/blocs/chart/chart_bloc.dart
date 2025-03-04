import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../models/candle_stick_model.dart';
import '../../repositories/trading_repository.dart';
import 'chart_event.dart';
import 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  final TradingRepository repository;
  StreamSubscription? _subscription;

  ChartBloc({required this.repository}) : super(ChartInitial()) {
    on<LoadChartData>(_onLoadChartData);
    on<UpdateChartData>(_onUpdateChartData);
  }

  void _onLoadChartData(LoadChartData event, Emitter<ChartState> emit) {
    emit(ChartLoading());
    
    _subscription?.cancel();
    repository.connectToStreams(event.symbol, event.interval);
    
    _subscription = repository.candlestickStream.listen((candlestick) {
      add(UpdateChartData(candlestick: candlestick));
    });
  }

  void _onUpdateChartData(UpdateChartData event, Emitter<ChartState> emit) {
    if (state is ChartLoaded) {
      final currentState = state as ChartLoaded;
      
    
      List<CandlestickModel> updatedList = List.from(currentState.candlesticks);
      
  
      updatedList.add(event.candlestick);
      
      emit(ChartLoaded(
        candlesticks: updatedList,
        interval: currentState.interval,
      ));
    } else {
      emit(ChartLoaded(
        candlesticks: [event.candlestick],
        interval: 'default',
      ));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}