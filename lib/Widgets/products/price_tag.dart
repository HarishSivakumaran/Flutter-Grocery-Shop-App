import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget{
 final double price;
  PriceTag(this.price);
  @override
  Widget build(BuildContext context){

    return  Container(
                  padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
                  margin: EdgeInsets.only(left: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Colors.amber,
                  ),
                  child: Text(
                    "\$$price",
                    style: TextStyle(color: Colors.white),
                  ),
                );
  }
}