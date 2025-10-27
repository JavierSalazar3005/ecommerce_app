import 'dart:convert';
import '../models/order.dart';
import '../models/order_item.dart';
import 'api_service.dart';

class OrderService {
  final _api = ApiService();

  Future<Order> create(List<OrderItem> items, double total) async {
    final body = {
      "customerId": 0, // el backend lo toma del JWT
      "total": total,
      "items": items.map((e) => e.toJson()).toList(),
    };

    final res = await _api.post("/order", body);
    if (res.statusCode == 201) {
      return Order.fromJson(jsonDecode(res.body));
    }
    throw Exception("Error creating order: ${res.statusCode}");
  }

  Future<bool> confirm(int id) async {
    final res = await _api.post("/order/$id/confirm", {});
    return res.statusCode == 200;
  }

  Future<bool> cancel(int id) async {
    final res = await _api.post("/order/$id/cancel", {});
    return res.statusCode == 200;
  }
}
