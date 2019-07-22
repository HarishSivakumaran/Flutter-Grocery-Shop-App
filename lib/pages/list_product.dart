import 'package:flutter/material.dart';
import 'package:navigation_practice/pages/create_product.dart';
import 'package:navigation_practice/scoped_models/main_scoped.dart';
import 'package:scoped_model/scoped_model.dart';

class ListProductsPage extends StatefulWidget {
  final MainScopedModel model;
  ListProductsPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ListProductsPageState();
  }
}

class _ListProductsPageState extends State<ListProductsPage> {
  @override
  void initState() {
    super.initState();
    widget.model.fetchData();
  }

  Widget _buildItems(BuildContext context, int index) {
    return ScopedModelDescendant<MainScopedModel>(
      builder: (BuildContext context, Widget child, MainScopedModel model) {
        return (Dismissible(
          key: Key(model.products[index].title),
          onDismissed: (DismissDirection dissmisDirection) {
            if (dissmisDirection == DismissDirection.endToStart) {
              model.selectedProductID = model.products[index].id;
              model.deleteProduct().then((bool onValue) {
                if (onValue) {
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Something went wrong!"),
                          content: Text("Please check your network connectivity"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Okay"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      });
                }
              });
            }
          },
          background: Container(
            color: Colors.redAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.delete_forever,
                  size: 45.0,
                  color: Colors.white,
                )
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(model.products[index].imageURL),
                  radius: 30.0,
                ),
                title: Text(
                  model.products[index].title,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text("\$${model.products[index].price}"),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    model.selectedProductID = model.products[index].id;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CreateAndEditProductPage()),
                    ).then((_) {
                      model.selectedProductID = null;
                    });
                  },
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              ),
              Divider(color: Colors.blueGrey),
            ],
          ),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopedModel>(
      builder: (BuildContext context, Widget child, MainScopedModel model) {
        return ListView.builder(
          itemCount: model.products.length,
          itemBuilder: _buildItems,
        );
      },
    );
  }
}
