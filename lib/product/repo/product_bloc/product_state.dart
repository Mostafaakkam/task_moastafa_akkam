class ProductState {
  Status? productStatus;
  Status? detailsStatus;
  List<dynamic>? products; // List<ProductModel>
  dynamic productDetails; // ProductModel?
  Map<int, CartItem> cart; // key: product id

  ProductState({
    this.productStatus = Status.init,
    this.detailsStatus = Status.init,
    this.products,
    this.productDetails,
    Map<int, CartItem>? cart,
  }) : cart = cart ?? {};

  ProductState copyWith({
    Status? productStatus,
    Status? detailsStatus,
    List<dynamic>? products,
    dynamic productDetails,
    Map<int, CartItem>? cart,
  }) =>
      ProductState(
        productStatus: productStatus ?? this.productStatus,
        detailsStatus: detailsStatus ?? this.detailsStatus,
        products: products ?? this.products,
        productDetails: productDetails ?? this.productDetails,
        cart: cart ?? this.cart,
      );

  List<CartItem> get cartItems => cart.values.toList();
  double get cartTotal => cart.values.fold(0.0, (sum, item) => sum + (item.product.price ?? 0) * item.qty);

  ProductState addToCart(dynamic product) { // product: ProductModel
    final id = product.id as int?;
    if (id == null) return this;
    final existing = cart[id];
    final updated = Map<int, CartItem>.from(cart);
    if (existing == null) {
      updated[id] = CartItem(product: product, qty: 1);
    } else {
      updated[id] = existing.copyWith(qty: existing.qty + 1);
    }
    return copyWith(cart: updated);
  }

  ProductState removeFromCart(int id) {
    if (!cart.containsKey(id)) return this;
    final existing = cart[id]!;
    final updated = Map<int, CartItem>.from(cart);
    if (existing.qty <= 1) {
      updated.remove(id);
    } else {
      updated[id] = existing.copyWith(qty: existing.qty - 1);
    }
    return copyWith(cart: updated);
  }
}

enum Status { init, error, success, loading }

class CartItem {
  final dynamic product; // ProductModel
  final int qty;
  const CartItem({required this.product, required this.qty});

  CartItem copyWith({dynamic product, int? qty}) =>
      CartItem(product: product ?? this.product, qty: qty ?? this.qty);
}