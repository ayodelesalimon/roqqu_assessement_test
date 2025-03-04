import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../config/constants.dart';

import '../models/candle_stick_model.dart';
import '../models/orderbook_entry_model.dart';
import '../models/trade_model.dart';

class BinanceWebSocket {
  WebSocketChannel? _klineChannel;
  WebSocketChannel? _depthChannel;
  WebSocketChannel? _tradesChannel;

  final _klineStreamController = StreamController<CandlestickModel>.broadcast();
  final _depthStreamController = StreamController<OrderbookModel>.broadcast();
  final _tradesStreamController = StreamController<TradeModel>.broadcast();

  Stream<CandlestickModel> get klineStream => _klineStreamController.stream;
  Stream<OrderbookModel> get depthStream => _depthStreamController.stream;
  Stream<TradeModel> get tradesStream => _tradesStreamController.stream;

  void connectToKlineStream(String symbol, String interval) {
    _klineChannel?.sink.close();
    
    final wsUrl = '${ApiConstants.baseWsUrl}/$symbol@kline_$interval';
    _klineChannel = WebSocketChannel.connect(Uri.parse(wsUrl));
    
    _klineChannel!.stream.listen((data) {
      final jsonData = jsonDecode(data);
      if (jsonData['e'] == 'kline') {
        final kline = CandlestickModel.fromJson(jsonData);
        _klineStreamController.add(kline);
      }
    });
  }

  void connectToDepthStream(String symbol) {
    _depthChannel?.sink.close();
    
    final wsUrl = '${ApiConstants.baseWsUrl}/$symbol@depth20@100ms';
    _depthChannel = WebSocketChannel.connect(Uri.parse(wsUrl));
    
    _depthChannel!.stream.listen((data) {
      final jsonData = jsonDecode(data);
      final orderbook = OrderbookModel.fromJson(jsonData);
      _depthStreamController.add(orderbook);
    });
  }

  void connectToTradesStream(String symbol) {
    _tradesChannel?.sink.close();
    
    final wsUrl = '${ApiConstants.baseWsUrl}/$symbol@trade';
    _tradesChannel = WebSocketChannel.connect(Uri.parse(wsUrl));
    
    _tradesChannel!.stream.listen((data) {
      final jsonData = jsonDecode(data);
      final trade = TradeModel.fromJson(jsonData);
      _tradesStreamController.add(trade);
    });
  }

  void closeAllConnections() {
    _klineChannel?.sink.close();
    _depthChannel?.sink.close();
    _tradesChannel?.sink.close();
    
    _klineStreamController.close();
    _depthStreamController.close();
    _tradesStreamController.close();
  }
}