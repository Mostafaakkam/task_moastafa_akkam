import 'dart:convert';

import 'package:task_moastafa_akkam/product/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  Future<List<ProductModel>> getProducts() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to load products');
    }
    final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    return data.map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<ProductModel> getProductDetails(int id) async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to load product');
    }
    final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    return ProductModel.fromJson(data);
  }
}