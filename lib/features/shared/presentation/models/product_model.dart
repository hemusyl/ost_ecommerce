class ProductModel {
  final String id;
  final String title;
  final List<String> photos;
  final int currentPrice;
  final double rating;
  final String? brand;
  final List<String>? tags;

  ProductModel({
    required this.id,
    required this.title,
    required this.photos,
    required this.currentPrice,
    required this.rating,
    this.brand,
    this.tags,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductModel(
      id: jsonData['_id'],
      title: jsonData['title'],
      photos: List<String>.from(jsonData['photos'].map((e) => e).toList()),
      currentPrice: jsonData['current_price'],
      rating: 2.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'photos': photos,
      'current_price': currentPrice,
      'rating': rating,
      'brand': brand,
      'tags': tags,
    };
  }

}