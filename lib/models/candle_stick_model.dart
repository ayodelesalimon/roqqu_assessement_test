class CandlestickModel {
  final dynamic timestamp;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  CandlestickModel({
    required this.timestamp,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  factory CandlestickModel.fromJson(Map<String, dynamic> json) {
    final klineData = json['k'] as Map<String, dynamic>;

    return CandlestickModel(
      timestamp: DateTime.fromMillisecondsSinceEpoch(klineData['t'] as int),
      open: double.tryParse(klineData['o'].toString()) ?? 0.0,
      high: double.tryParse(klineData['h'].toString()) ?? 0.0,
      low: double.tryParse(klineData['l'].toString()) ?? 0.0,
      close: double.tryParse(klineData['c'].toString()) ?? 0.0,
      volume: double.tryParse(klineData['v'].toString()) ?? 0.0,
    );
  }
}
