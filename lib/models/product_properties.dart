class ProductProperties {
  String collectionId;
  String id;
  String productId;
  String title;
  String value;

  ProductProperties({
    required this.collectionId,
    required this.id,
    required this.productId,
    required this.title,
    required this.value,
  });

  factory ProductProperties.getFromJsonMapObject(Map<String, dynamic> jsonObject) {
    return ProductProperties(
      collectionId: jsonObject['collectionId'],
      id: jsonObject['id'],
      productId: jsonObject['product_id'],
      title: jsonObject['title'],
      value: jsonObject['value'],
    );
  }
}
