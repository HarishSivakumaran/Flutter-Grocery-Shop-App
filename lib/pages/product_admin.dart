import 'package:flutter/material.dart';
import 'package:navigation_practice/Widgets/ui_elements/logout_tile.dart';
import 'package:navigation_practice/pages/products_page.dart';
import 'package:navigation_practice/scoped_models/main_scoped.dart';
import './create_product.dart';
import './list_product.dart';
import '../models/product_type.dart';
import 'package:scoped_model/scoped_model.dart';

class ManageProducts extends StatelessWidget {
  final MainScopedModel model;
  ManageProducts(this.model);
  Widget _buildDrawer(BuildContext context) => Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text("Choose Page"),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text("Products Page"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            LogoutListTile(),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Product Admin"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Create Product",
                icon: Icon(Icons.create),
              ),
              Tab(
                text: "My Products",
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),
        drawer: _buildDrawer(context),
        body: ScopedModelDescendant<MainScopedModel>(builder:
            (BuildContext context, Widget child, MainScopedModel model) {
          return TabBarView(
            children: <Widget>[
              CreateAndEditProductPage(),
              ListProductsPage(model),
            ],
          );
        }),
      ),
    );
  }
}
