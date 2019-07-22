import 'package:flutter/material.dart';

class AddressTag extends StatelessWidget {
  final String address;
  AddressTag(this.address);
  @override
  Widget build(BuildContext context) {
    return (Container(
        margin: EdgeInsets.only(top: 5.0),
        padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            border: Border.all(
                color: Colors.grey, width: 1, style: BorderStyle.solid)),
        child: Text(
          address,
        )));
  }
}
