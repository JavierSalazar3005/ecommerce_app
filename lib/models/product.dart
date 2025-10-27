class Product {
  final int id;
  final String name;
  final String? description;
  final double price;
  final int stock;
  final String? imageUrl;
  final bool isActive;
  final int companyId;
  final String? companyName;

  Product({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.stock,
    this.imageUrl,
    required this.isActive,
    required this.companyId,
    this.companyName,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: (json["price"] as num).toDouble(),
        stock: json["stock"],
        imageUrl: json["imageUrl"],
        isActive: json["isActive"] ?? true,
        companyId: json["companyId"],
        companyName: json["companyName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "imageUrl": imageUrl,
        "isActive": isActive,
        "companyId": companyId,
        "companyName": companyName,
      };
}
