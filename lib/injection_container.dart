import 'package:get_it/get_it.dart';
import 'blocs/chart/chart_bloc.dart';
import 'blocs/orderbook/orderbook_bloc.dart';
import 'blocs/theme/theme_bloc.dart';
import 'blocs/trade/trade_bloc.dart';
import 'repositories/binance_repository.dart';
import 'repositories/trading_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => ChartBloc(repository: sl()));
  sl.registerFactory(() => OrderbookBloc(repository: sl()));
  sl.registerFactory(() => TradesBloc(repository: sl()));
  sl.registerFactory(() => ThemeBloc());
  sl.registerLazySingleton<TradingRepository>(
    () => TradingRepository(websocket: sl()),
  );
  sl.registerLazySingleton<BinanceWebSocket>(
    () => BinanceWebSocket(),
  );
}
