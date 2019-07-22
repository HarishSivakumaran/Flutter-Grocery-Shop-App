import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

class MapFullPage extends StatelessWidget {
  final Uri uri;
  MapFullPage(this.uri);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Image.network(
          uri.toString(),
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height ,
        ),
      ),
    );
  }
}
