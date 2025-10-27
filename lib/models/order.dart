import 'order_item.dart';

class Order {
  final int id;
  final int customerId;
  final double total;
  final String status;
  final DateTime createdAt;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.customerId,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        customerId: json["customerId"],
        total: (json["total"] as num).toDouble(),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        items: (json["items"] as List)
            .map((e) => OrderItem(
                  productId: e["productId"],
                  productName: e["productName"] ?? "",
                  quantity: e["quantity"],
                  unitPrice: (e["unitPrice"] as num).toDouble(),
                  companyId: e["companyId"],
                ))
            .toList(),
      );
}
