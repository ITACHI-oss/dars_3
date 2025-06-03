import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dars_3/features/product/domain/entities/product.dart';
import 'package:dars_3/features/product/domain/repositories/product_repository.dart';

part 'single_product_event.dart';
part 'single_product_state.dart';

class SingleProductBloc extends Bloc<SingleProductEvent, SingleProductState> {
  final ProductRepository repository;

  SingleProductBloc(this.repository) : super(SingleProductInitial()) {
    on<FetchSingleProduct>((event, emit) async {
      emit(SingleProductLoading());
      try {
        final product = await repository.getProductById(event.id);
        emit(SingleProductLoaded(product));
      } catch (e) {
        emit(SingleProductError(e.toString()));
      }
    });
  }
}
