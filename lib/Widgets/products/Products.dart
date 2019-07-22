import 'package:flutter/material.dart';
import 'package:navigation_practice/Widgets/products/product_card.dart';
import 'package:navigation_practice/scoped_models/main_scoped.dart';
import '../../models/product_type.dart';
import 'package:scoped_model/scoped_model.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopedModel>(builder:
        (BuildContext context, Widget child, MainScopedModel model) {
      return ListView.builder(
        itemCount: model.diplayFilteredProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(model.diplayFilteredProducts, index);
        },
      );
    });
  }
}
