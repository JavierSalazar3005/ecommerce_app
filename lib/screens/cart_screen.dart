import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/cart_state.dart';
import '../services/order_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _orderService = OrderService();
  bool _loading = false;

  Future<void> _createOrder(BuildContext context) async {
    final cart = Provider.of<CartState>(context, listen: false);
    if (cart.items.isEmpty) return;

    setState(() => _loading = true);
    try {
      await _orderService.create(cart.items, cart.total);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pedido creado exitosamente")),
      );
      cart.clear();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error creando pedido: $e")),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Carrito")),
      body: cart.items.isEmpty
          ? const Center(child: Text("Tu carrito está vacío"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (_, i) {
                      final item = cart.items[i];
                      return ListTile(
                        title: Text(item.productName),
                        subtitle: Text(
                          "x${item.quantity}  •  ${item.unitPrice.toStringAsFixed(2)}",
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () =>
                                  cart.decreaseQuantity(item.productId),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () =>
                                  cart.increaseQuantity(item.productId),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  cart.removeItem(item.productId),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total: ${cart.total.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _loading
                            ? null
                            : () => _createOrder(context),
                        child: _loading
                            ? const CircularProgressIndicator()
                            : const Text("Crear pedido"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
