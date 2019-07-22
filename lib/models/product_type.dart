import 'package:flutter/material.dart';
import 'package:navigation_practice/models/location_data.dart';

class Product {
  String title;
  String description;
  double price;
  String id;
  String imageURL;
  bool isFavourite;
  String userID;
  LocationData locationData;
  String email;
  String imagePath;
  Product({
    @required this.id,
    @required this.description,
    @required this.imageURL,
    @required this.price,
    @required this.title,
    this.isFavourite = false,
    @required this.email,
    @required this.userID,
    @required this.locationData,
    this.imagePath
  });
}
