import 'package:dars_3/features/product/presentation/bloc/product_bloc.dart';
import 'package:dars_3/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AllProductsBloc>()..add(FetchAllProducts()),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "Products",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
        ),
        body: BlocBuilder<AllProductsBloc, AllProductsState>(
          builder: (context, state) {
            if (state is AllProductsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AllProductsLoaded) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (_, index) {
                  final product = state.products[index];
                  return ListTile(
                    title: Text(
                      product.title,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      '${product.price} \$',
                      style: TextStyle(color: Colors.grey),
                    ),
                    leading: Image.network(product.image, width: 50),
                  );
                },
              );
            } else if (state is AllProductsError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
