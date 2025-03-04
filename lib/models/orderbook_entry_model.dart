class OrderbookModel {
  final List<OrderbookEntry> bids;
  final List<OrderbookEntry> asks;
  final int lastUpdateId;

  OrderbookModel({
    required this.bids,
    required this.asks,
    required this.lastUpdateId,
  });

  factory OrderbookModel.fromJson(Map<String, dynamic> json) {
    return OrderbookModel(
      lastUpdateId: json['lastUpdateId'],
      bids: (json['bids'] as List)
          .map((e) => OrderbookEntry(
                price: double.parse(e[0]),
                quantity: double.parse(e[1]),
              ))
          .toList(),
      asks: (json['asks'] as List)
          .map((e) => OrderbookEntry(
                price: double.parse(e[0]),
                quantity: double.parse(e[1]),
              ))
          .toList(),
    );
  }
}

class OrderbookEntry {
  final double price;
  final double quantity;

  OrderbookEntry({
    required this.price,
    required this.quantity,
  });
}