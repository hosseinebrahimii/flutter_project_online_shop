class Banners {
  String categoryId;
  String collectionId;
  String id;
  String thumbnail;
  Banners({
    required this.categoryId,
    required this.collectionId,
    required this.id,
    required this.thumbnail,
  });

  factory Banners.getFromJsonMapObject(Map<String, dynamic> jsonObject) {
    return Banners(
      categoryId: jsonObject['categoryId'],
      collectionId: jsonObject['collectionId'],
      id: jsonObject['id'],
      thumbnail: jsonObject['thumbnail'],
    );
  }
  String getImageUrl() {
    return 'http://startflutter.ir/api/files/$collectionId/$id/$thumbnail';
  }
}
