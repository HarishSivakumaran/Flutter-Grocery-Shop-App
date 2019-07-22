import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddProduct extends StatelessWidget {

  final Function addProduct;

AddProduct({this.addProduct});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: addProduct,
      child: Text(
        "Add Product",
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
    );
  }
}
