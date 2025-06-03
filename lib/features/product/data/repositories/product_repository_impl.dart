import 'package:dars_3/features/product/data/model/product_model.dart';
import 'package:dars_3/features/product/domain/entities/product.dart';
import 'package:dars_3/features/product/domain/repositories/product_repository.dart';
import 'package:dio/dio.dart';

class ProductRepositoryImpl implements ProductRepository {
  final Dio dio;

  ProductRepositoryImpl({required this.dio});

  @override
  Future<List<Product>> getAllProducts() async {
    final response = await dio.get('/products');
    final data = response.data as List;
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }

  @override
  Future<Product> getProductById(int id) async {
    final response = await dio.get('/products/$id');
    return ProductModel.fromJson(response.data);
  }
}
