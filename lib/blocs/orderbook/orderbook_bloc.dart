import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../repositories/trading_repository.dart';
import 'orderbook_event.dart';
import 'orderbook_state.dart';

class OrderbookBloc extends Bloc<OrderbookEvent, OrderbookState> {
  final TradingRepository repository;
  StreamSubscription? _subscription;

  OrderbookBloc({required this.repository}) : super(OrderbookInitial()) {
    on<LoadOrderbook>(_onLoadOrderbook);
    on<UpdateOrderbook>(_onUpdateOrderbook);
  }

  void _onLoadOrderbook(LoadOrderbook event, Emitter<OrderbookState> emit) {
    emit(OrderbookLoading());
    
    _subscription?.cancel();
    // Repository already connects to streams in ChartBloc
    
    _subscription = repository.orderbookStream.listen((orderbook) {
      add(UpdateOrderbook(orderbook: orderbook));
    });
  }

  void _onUpdateOrderbook(UpdateOrderbook event, Emitter<OrderbookState> emit) {
    emit(OrderbookLoaded(orderbook: event.orderbook));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}