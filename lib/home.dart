import 'package:Shrine/model/product.dart';
import 'package:Shrine/model/products_repository.dart';
import 'package:Shrine/supplemental/asymmetric_view.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final Category category;

  Home({this.category: Category.all});

  @override
  Widget build(BuildContext context) {
    return AsymmetricView(
      products: ProductsRepository.loadProducts(category),
    );
  }
}
