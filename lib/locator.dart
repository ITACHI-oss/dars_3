import 'package:dars_3/features/product/data/repositories/auth_repository_impl.dart';
import 'package:dars_3/features/product/data/repositories/product_repository_impl.dart';
import 'package:dars_3/features/product/domain/repositories/auth_repository.dart';
import 'package:dars_3/features/product/domain/repositories/product_repository.dart';
import 'package:dars_3/features/product/presentation/bloc/product_bloc.dart';
import 'package:dars_3/features/product/presentation/bloc/single_product_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com'));
    dio.interceptors.add(LogInterceptor(responseBody: true));
    return dio;
  });

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(dio: sl()),
  );

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(dio: sl()));

  sl.registerFactory<AllProductsBloc>(() => AllProductsBloc(sl()));
  sl.registerFactory<SingleProductBloc>(() => SingleProductBloc(sl()));
}
