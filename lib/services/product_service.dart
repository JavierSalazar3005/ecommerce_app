import 'dart:convert';
import '../models/product.dart';
import 'api_service.dart';

class ProductService {
  final _api = ApiService();

  Future<List<Product>> getAll({String? search, int? companyId}) async {
    final params = <String, String>{};
    if (search != null && search.isNotEmpty) params["search"] = search;
    if (companyId != null) params["companyId"] = companyId.toString();

    final query = params.entries
        .map((e) => "${e.key}=${Uri.encodeQueryComponent(e.value)}")
        .join("&");

    final path = "/product${query.isEmpty ? "" : "?$query"}";
    final res = await _api.get(path);

    if (res.statusCode == 200) {
      final list = jsonDecode(res.body) as List;
      return list.map((e) => Product.fromJson(e)).toList();
    }

    throw Exception("Error fetching products: ${res.statusCode}");
  }
}