import 'package:flutter/material.dart';
import 'package:dars_3/locator.dart';
import 'package:dars_3/features/product/presentation/screens/product_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      home: ProductScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
