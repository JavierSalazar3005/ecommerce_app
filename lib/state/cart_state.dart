import 'package:flutter/foundation.dart';
import '../models/order_item.dart';

class CartState extends ChangeNotifier {
  final List<OrderItem> _items = [];

  List<OrderItem> get items => List.unmodifiable(_items);

  double get total =>
      _items.fold(0, (sum, item) => sum + item.unitPrice * item.quantity);

  int get count => _items.fold(0, (sum, item) => sum + item.quantity);

  void addItem(OrderItem item) {
    final index = _items.indexWhere((i) => i.productId == item.productId);
    if (index >= 0) {
      _items[index].quantity++; // ✅ incrementa uno si ya existe
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(int productId) {
    _items.removeWhere((i) => i.productId == productId);
    notifyListeners();
  }

  void increaseQuantity(int productId) {
    final index = _items.indexWhere((i) => i.productId == productId);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(int productId) {
    final index = _items.indexWhere((i) => i.productId == productId);
    if (index >= 0 && _items[index].quantity > 1) {
      _items[index].quantity--;
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
