import 'package:flutter/material.dart';
import 'package:navigation_practice/Widgets/ui_elements/logout_tile.dart';
import 'package:navigation_practice/scoped_models/main_scoped.dart';
import '../Widgets/products/Products.dart';
import '../models/product_type.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsPage extends StatefulWidget {
  final MainScopedModel model;
  ProductsPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> {
  void initState() {
    super.initState();
    widget.model.fetchData();
   
  }

  Widget _buildBody() {
    return ScopedModelDescendant<MainScopedModel>(
      builder: (BuildContext context, Widget child, MainScopedModel model) {
       
        if (model.diplayFilteredProducts.length > 0 && !model.isLoading) {
          return RefreshIndicator(
            child: Products(),
            onRefresh: model.fetchData,
          );
        } else if (model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else
          return Center(
            child: Text("No Products Found!"),
          );
      },
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return (Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("Choose"),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Manage Products"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
          LogoutListTile(),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        actions: <Widget>[
          ScopedModelDescendant<MainScopedModel>(builder:
              (BuildContext context, Widget child, MainScopedModel model) {
            return IconButton(
              icon: Icon(model.shouldDisplayFavourites
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Colors.white,
              onPressed: () {
                model.toggleFavDisplay();
              },
            );
          }),
        ],
        title: Text(
          "Easy List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }
}
