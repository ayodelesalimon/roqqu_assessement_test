class TradeModel {
  final int id;
  final double price;
  final double quantity;
  final DateTime time;
  final bool isBuyerMaker;

  TradeModel({
    required this.id,
    required this.price,
    required this.quantity,
    required this.time,
    required this.isBuyerMaker,
  });

  factory TradeModel.fromJson(Map<String, dynamic> json) {
    return TradeModel(
      id: json['t'],
      price: double.parse(json['p']),
      quantity: double.parse(json['q']),
      time: DateTime.fromMillisecondsSinceEpoch(json['T']),
      isBuyerMaker: json['m'],
    );
  }
}