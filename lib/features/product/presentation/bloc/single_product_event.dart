part of 'single_product_bloc.dart';

abstract class SingleProductEvent {}

class FetchSingleProduct extends SingleProductEvent {
  final int id;
  FetchSingleProduct(this.id);
}
