import 'package:dars_3/features/product/domain/entities/product.dart';
import 'package:dars_3/features/product/domain/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part "product_event.dart";
part "product_state.dart";

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  final ProductRepository repository;

  AllProductsBloc(this.repository) : super(AllProductsInitial()) {
    on<FetchAllProducts>((event, emit) async {
      emit(AllProductsLoading());
      try {
        final products = await repository.getAllProducts();
        emit(AllProductsLoaded(products));
      } catch (e) {
        emit(AllProductsError(e.toString()));
      }
    });
  }
}
