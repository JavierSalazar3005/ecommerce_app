import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/order_item.dart';
import '../services/product_service.dart';
import '../state/cart_state.dart';
import '../widgets/product_card.dart';
import '../routes.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final _service = ProductService();
  List<Product> _products = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await _service.getAll();
      setState(() {
        _products = data;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error cargando productos: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catálogo"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Navigator.pushNamed(context, RouteNames.cart),
              ),
              if (cart.count > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      "${cart.count}",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                )
            ],
          )
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (_, i) {
                  final p = _products[i];
                  return ProductCard(
                    product: p,
                    onAdd: () {
                      cart.addItem(
                        OrderItem(
                          productId: p.id,
                          productName: p.name,
                          quantity: 1,
                          unitPrice: p.price,
                          companyId: p.companyId,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
