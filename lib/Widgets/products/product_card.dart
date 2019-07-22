import 'package:flutter/material.dart';
import 'package:navigation_practice/Widgets/products/address_tag.dart';
import 'package:navigation_practice/Widgets/ui_elements/title_default.dart';
import 'package:navigation_practice/scoped_models/main_scoped.dart';
import 'package:scoped_model/scoped_model.dart';
import './price_tag.dart';
import '../../models/product_type.dart';

class ProductCard extends StatelessWidget {
  final List<Product> productsList;
  final int index;
  ProductCard(this.productsList, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            width: MediaQuery.of(context).size.width,
            image: NetworkImage(productsList[index].imageURL),
            placeholder: AssetImage("assets/auth_bg.jpeg"),
            height: 300.0,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleDefault(productsList[index].title),
                PriceTag(productsList[index].price),
              ],
            ),
          ),
          AddressTag(productsList[index].locationData.address),
          SizedBox(
            height: 7.0,
          ),
          ScopedModelDescendant<MainScopedModel>(
            builder:
                (BuildContext context, Widget child, MainScopedModel model) {
              return Text(model.products[index].email);
            },
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ScopedModelDescendant<MainScopedModel>(
                builder: (BuildContext context, Widget child,
                    MainScopedModel model) {
                  return IconButton(
                    icon: Icon(Icons.info),
                    color: Colors.blueAccent,
                    onPressed: () {
                      Navigator.pushNamed(context, '/product/$index');
                    },
                  );
                },
              ),
              ScopedModelDescendant<MainScopedModel>(
                builder: (BuildContext context, Widget child,
                    MainScopedModel model) {
                  IconData icon = productsList[index].isFavourite
                      ? Icons.favorite
                      : Icons.favorite_border;
                  return IconButton(
                    icon: Icon(icon),
                    color: Colors.red,
                    onPressed: () {
                      model.selectedProductID = model.products[index].id;
                      model.toggleFavouriteProduct(index);
                    },
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
