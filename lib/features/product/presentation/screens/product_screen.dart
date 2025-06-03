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
          shadowColor: Colors.green,
          elevation: 10,
          centerTitle: true,
          title: Text(
            "Products",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: BlocBuilder<AllProductsBloc, AllProductsState>(
          builder: (context, state) {
            if (state is AllProductsLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (state is AllProductsLoaded) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 15,
                      left: 15,
                      top: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(color: Colors.green, blurRadius: 15),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              product.image,
                              height: 80,
                              width: 100,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      Icon(Icons.error, color: Colors.red),
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.green,
                                    value:
                                        loadingProgress.expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 8),
                            Text(
                              product.title,
                              style: TextStyle(color: Colors.green),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4),
                            Text(
                              '\$${product.price}',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
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
