class OrderItem {
  final int productId;
  final String productName;
  int quantity;
  final double unitPrice;
  final int companyId;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.companyId,
  });

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "quantity": quantity,
        "unitPrice": unitPrice,
        "companyId": companyId,
      };
}
