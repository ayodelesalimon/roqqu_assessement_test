
import '../models/candle_stick_model.dart';
import '../models/orderbook_entry_model.dart';
import '../models/trade_model.dart';
import 'binance_repository.dart';

class TradingRepository {
  final BinanceWebSocket websocket;

  TradingRepository({required this.websocket});

  void connectToStreams(String symbol, String interval) {
    websocket.connectToKlineStream(symbol, interval);
    websocket.connectToDepthStream(symbol);
    websocket.connectToTradesStream(symbol);
  }

  Stream<CandlestickModel> get candlestickStream => websocket.klineStream;
  Stream<OrderbookModel> get orderbookStream => websocket.depthStream;
  Stream<TradeModel> get tradesStream => websocket.tradesStream;

  void closeConnections() {
    websocket.closeAllConnections();
  }
}