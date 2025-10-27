import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text(
            product.name.isNotEmpty ? product.name[0].toUpperCase() : '?',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          "Precio: ${product.price.toStringAsFixed(2)}  •  Stock: ${product.stock}",
          style: TextStyle(color: Colors.grey.shade700),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          color: Colors.blue,
          onPressed: onAdd,
          tooltip: "Agregar al carrito",
        ),
      ),
    );
  }
}
