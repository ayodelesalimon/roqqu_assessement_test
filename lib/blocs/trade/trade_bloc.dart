import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../models/trade_model.dart';
import '../../repositories/trading_repository.dart';
import 'trade_event.dart';
import 'trade_state.dart';


class TradesBloc extends Bloc<TradesEvent, TradesState> {
  final TradingRepository repository;
  StreamSubscription? _subscription;
  final int _maxStoredTrades = 50;

  TradesBloc({required this.repository}) : super(TradesInitial()) {
    on<LoadTrades>(_onLoadTrades);
    on<UpdateTrades>(_onUpdateTrades);
  }

  void _onLoadTrades(LoadTrades event, Emitter<TradesState> emit) {
    emit(TradesLoading());
    
    _subscription?.cancel();
    // Repository already connects to streams in ChartBloc
    
    _subscription = repository.tradesStream.listen((trade) {
      add(UpdateTrades(trade: trade));
    });
  }

  void _onUpdateTrades(UpdateTrades event, Emitter<TradesState> emit) {
    if (state is TradesLoaded) {
      final currentState = state as TradesLoaded;
      
      // Add new trade and keep only the most recent ones
      List<TradeModel> updatedList = [event.trade, ...currentState.trades];
      if (updatedList.length > _maxStoredTrades) {
        updatedList = updatedList.sublist(0, _maxStoredTrades);
      }
      
      emit(TradesLoaded(trades: updatedList));
    } else {
      emit(TradesLoaded(trades: [event.trade]));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}