abstract class ProductEvent {}

class FetchProductsEvent extends ProductEvent {}

class FetchProductDetailsEvent extends ProductEvent {
  final int id;
  FetchProductDetailsEvent({required this.id});
}

class AddToCartEvent extends ProductEvent {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  AddToCartEvent({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });
}

class RemoveFromCartEvent extends ProductEvent {
  final int id;
  RemoveFromCartEvent({required this.id});
}
