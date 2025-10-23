class ProductModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        price: (json["price"] as num?)?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
      };
}
