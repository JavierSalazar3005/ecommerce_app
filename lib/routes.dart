import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/cart_screen.dart';

class RouteNames {
  static const login = '/login';
  static const catalog = '/catalog';
  static const cart = '/cart';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteNames.catalog:
        return MaterialPageRoute(builder: (_) => const CatalogScreen());
      case RouteNames.cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      default:
        return _notFound(settings.name);
    }
  }

  static Route<dynamic> _notFound(String? route) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Ruta no encontrada')),
        body: Center(child: Text('No existe la ruta: $route')),
      ),
    );
  }
}
