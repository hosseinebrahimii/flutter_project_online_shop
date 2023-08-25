class ProductDetail {
  String productId;

  String collectionId;
  String id;
  String image;

  ProductDetail({
    required this.collectionId,
    required this.productId,
    required this.id,
    required this.image,
  });

  factory ProductDetail.getFromJsonMapObject(Map<String, dynamic> jsonObject) {
    return ProductDetail(
      collectionId: jsonObject['collectionId'],
      productId: jsonObject['product_id'],
      id: jsonObject['id'],
      image: jsonObject['image'],
    );
  }

  String getImageUrl() {
    return 'http://startflutter.ir/api/files/$collectionId/$id/$image';
  }
}
