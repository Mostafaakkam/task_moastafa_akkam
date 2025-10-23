import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_moastafa_akkam/product/repo/product_bloc/product_event.dart';
import 'package:task_moastafa_akkam/product/repo/product_bloc/product_state.dart';

import '../product_repo.dart';
import '../../model/product_model.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo productRepo;

  ProductBloc(this.productRepo) : super(ProductState()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<FetchProductDetailsEvent>(_onFetchProductDetails);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
  }

  Future<void> _onFetchProducts(FetchProductsEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(productStatus: Status.loading));
    try {
      final List<ProductModel> products = await productRepo.getProducts();
      emit(state.copyWith(productStatus: Status.success, products: products));
    } catch (_) {
      emit(state.copyWith(productStatus: Status.error));
    }
  }

  Future<void> _onFetchProductDetails(FetchProductDetailsEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(detailsStatus: Status.loading));
    try {
      final ProductModel details = await productRepo.getProductDetails(event.id);
      emit(state.copyWith(detailsStatus: Status.success, productDetails: details));
    } catch (_) {
      emit(state.copyWith(detailsStatus: Status.error));
    }
  }

  Future<void> _onAddToCart(AddToCartEvent event, Emitter<ProductState> emit) async {
    final product = ProductModel(
      id: event.id,
      title: event.title,
      price: event.price,
      description: event.description,
      category: event.category,
      image: event.image,
    );
    emit(state.addToCart(product));
  }

  Future<void> _onRemoveFromCart(RemoveFromCartEvent event, Emitter<ProductState> emit) async {
    emit(state.removeFromCart(event.id));
  }
}
