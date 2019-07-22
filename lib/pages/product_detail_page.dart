import 'package:flutter/material.dart';
import 'package:navigation_practice/pages/map_fullscreen.dart';
import 'package:navigation_practice/scoped_models/main_scoped.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:map_view/map_view.dart';
import 'package:navigation_practice/Widgets/ui_elements/title_default.dart';
import '../models/product_type.dart';
import 'package:map_view/map_view.dart';

class ProductsDetailpage extends StatelessWidget {
  final String productID;

  ProductsDetailpage(this.productID);

  void _showMap(Product selProduct, BuildContext context) {
    // final List<Marker> markers = <Marker>[
    //   Marker("pos", "pos", selProduct.locationData.latitude,
    //       selProduct.locationData.longitude),
    // ];

    // CameraPosition cameraPosition = CameraPosition(
    //     Location(selProduct.locationData.latitude,
    //         selProduct.locationData.longitude),
    //     14.0);
    // MapView.setApiKey("AIzaSyDvquu68nN4ZWSELhAkMvj3VvFk-maR8zk");

    // MapView map = MapView();
    // map.show(
    //     MapOptions(
    //         showUserLocation: true,
    //         showMyLocationButton: true,
    //         initialCameraPosition: cameraPosition,
    //         mapViewType: MapViewType.normal,
    //         title: "Product Location"),
    //     toolbarActions: <ToolbarAction>[ToolbarAction("Close", 1)]);

    // map.onToolbarAction.listen((int id) {
    //   if (id == 1) {
    //     map.dismiss();
    //   }
    // });

    // map.onMapReady.listen((onData) {
    //   map.setMarkers(markers);
    // });

    // final List<Marker> markers = <Marker>[
    //   Marker('position', 'Position', selProduct.locationData.latitude,
    //       selProduct.locationData.longitude)
    // ];
    // final cameraPosition = CameraPosition(
    //     Location(selProduct.locationData.latitude,
    //         selProduct.locationData.longitude),
    //     14.0);
    // final mapView = MapView();
    // mapView.show(
    //     MapOptions(
    //         initialCameraPosition: cameraPosition,
    //         mapViewType: MapViewType.normal,
    //         title: 'Product Location'),
    //     toolbarActions: [
    //       ToolbarAction('Close', 1),
    //     ]);
    // mapView.onToolbarAction.listen((int id) {
    //   if (id == 1) {
    //     mapView.dismiss();
    //   }
    // });
    // mapView.onMapReady.listen((_) {
    //   mapView.setMarkers(markers);
    // });

    StaticMapProvider staticMapProvider =
        StaticMapProvider("AIzaSyDvquu68nN4ZWSELhAkMvj3VvFk-maR8zk");
    Uri uri = staticMapProvider.getStaticUriWithMarkers([
      Marker("a", "a", selProduct.locationData.latitude,
          selProduct.locationData.longitude)
    ],
        center: Location(selProduct.locationData.latitude,
            selProduct.locationData.longitude));
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MapFullPage(uri);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScopedModelDescendant<MainScopedModel>(
        builder: (BuildContext context, Widget child, MainScopedModel model) {
          Product selProduct = model.products.firstWhere((Product product) {
            return product.id == productID;
          });

          return WillPopScope(
            onWillPop: () {
              model.selectedProductID = null;
              return Future.value(true);
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(selProduct.title),
              ),
              body: Column(
                children: <Widget>[
                  FadeInImage(
                    image: NetworkImage(selProduct.imageURL),
                    height: 350,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    placeholder: AssetImage("assets/auth_bg.jpeg"),
                  ),
                  // Container(
                  //   margin: EdgeInsets.all(10.0),
                  //   child: RaisedButton(
                  //     onPressed: () {
                  //       showDialog(
                  //           context: context,
                  //           builder: (BuildContext context) {
                  //             return AlertDialog(
                  //               title: Text("Are you sure?"),
                  //               content: Text("It can't be undone!"),
                  //               actions: <Widget>[
                  //                 FlatButton(
                  //                   onPressed: () {
                  //                     Navigator.pop(context);
                  //                   },
                  //                   child: Text("Discard",style: TextStyle(fontSize: 20.0),),
                  //                 ),
                  //                 FlatButton(
                  //                   onPressed: () {
                  //                     Navigator.pop(context);
                  //                     Navigator.pop(context, true);
                  //                   },
                  //                   child: Text("Continue",style: TextStyle(fontSize: 20.0),),
                  //                 )
                  //               ],
                  //             );
                  //           });
                  //     },
                  //     child: Text("Delete Product"),
                  //   ),
                  // ),
                  TitleDefault(selProduct.title),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _showMap(selProduct, context);
                        },
                        child: Container(
                          child: Text(
                              selProduct.locationData.address.substring(
                                  0,
                                  selProduct.locationData.address.length > 50
                                      ? 50
                                      : selProduct.locationData.address.length),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: "Oswald",
                              )),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("|",
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Oswald",
                            )),
                      ),
                      Text("\$" + selProduct.price.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Oswald",
                          )),
                    ],
                  ),
                  Container(
                    child: Text(
                      selProduct.description,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(10.0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
