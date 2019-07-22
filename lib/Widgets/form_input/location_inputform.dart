import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "package:map_view/map_view.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/product_type.dart';
import 'package:location/location.dart' as geoloc;
import 'package:navigation_practice/models/location_data.dart';
import 'dart:convert';

class LocationFormField extends StatefulWidget {
  Function setLocation;
  Product product;

  LocationFormField(this.setLocation, {this.product});
  @override
  State<StatefulWidget> createState() {
    return _LocationFormFieldState();
  }
}

class _LocationFormFieldState extends State<LocationFormField> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();
  Uri staticUri;
  LocationData locationData;
  StaticMapProvider staticMapProvider;
  @override
  void initState() {
    super.initState();
    focusNode.addListener(updateAddress);
    if (widget.product != null) {
      textEditingController.text = widget.product.locationData.address;
      getStaticUri(widget.product.locationData.address);
    }
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.removeListener(updateAddress);
  }

  void getStaticUri(String address) {
    if (address.isEmpty) {
      setState(() {
        staticUri = null;
      });
      return;
    }

    final Uri uri = Uri.https('maps.googleapis.com', '/maps/api/geocode/json',
        {"address": address, "key": "AIzaSyDvquu68nN4ZWSELhAkMvj3VvFk-maR8zk"});

    http.get(uri).then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      final formattedAddress = responseData["results"][0]["formatted_address"];
      final coords = responseData["results"][0]["geometry"]["location"];
      locationData = LocationData(
          address: formattedAddress,
          latitude: coords['lat'],
          longitude: coords['lng']);
      textEditingController.text = formattedAddress.toString();
      staticMapProvider =
          StaticMapProvider("AIzaSyDvquu68nN4ZWSELhAkMvj3VvFk-maR8zk");
      staticUri = staticMapProvider.getStaticUriWithMarkers(
        [
          Marker("position", "positon", locationData.latitude,
              locationData.longitude)
        ],
        center: Location(
          coords["lat"],
          coords["lng"],
        ),
        height: 300,
        width: 500,
        maptype: StaticMapViewType.roadmap,
      );
      setState(() {
        textEditingController.text = formattedAddress;
        widget.setLocation(locationData);
      });
    });
  }

  void updateAddress() {
    if (!focusNode.hasFocus) {
      getStaticUri(textEditingController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          focusNode: focusNode,
          controller: textEditingController,
          decoration: InputDecoration(
              labelText: "Address",
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.my_location,
                  color: Colors.blue,
                ),
                onPressed: () {
                  geoloc.Location location = geoloc.Location();
                  location.getLocation().then((geoloc.LocationData locationD) {
                    print(locationD.latitude.toString() +
                        " !!!!!!!!!!!!!!!!! " +
                        locationD.longitude.toString());
                    locationData = LocationData(
                        latitude: locationD.latitude,
                        longitude: locationD.longitude);

                    final Uri uri = Uri.https(
                        'maps.googleapis.com', '/maps/api/geocode/json', {
                      "latlng":
                          '${locationData.latitude.toString()},${locationData.longitude.toString()}',
                      "key": "AIzaSyDvquu68nN4ZWSELhAkMvj3VvFk-maR8zk"
                    });
                    http.get(uri).then((http.Response response) {
                      final Map<String, dynamic> responseData =
                          json.decode(response.body);
                      final formattedAddress2 =
                          responseData["results"][0]["formatted_address"];
                      locationData.address = formattedAddress2.toString();
                      textEditingController.text = formattedAddress2.toString();
                      staticMapProvider = StaticMapProvider(
                          "AIzaSyDvquu68nN4ZWSELhAkMvj3VvFk-maR8zk");
                      staticUri = staticMapProvider.getStaticUriWithMarkers(
                        [
                          Marker("position", "positon", locationD.latitude,
                              locationD.longitude)
                        ],
                        center: Location(
                          locationD.latitude,
                          locationD.longitude,
                        ),
                        height: 300,
                        width: 500,
                        maptype: StaticMapViewType.roadmap,
                      );
                      setState(() {
                        widget.setLocation(locationData);
                      });
                    });
                  });
                },
              )),
          validator: (String value) {
            if (value.isEmpty) {
              return "Invalid location";
            }
          },
        ),
        SizedBox(
          height: 7.0,
        ),
        staticUri == null ? Container() : Image.network(staticUri.toString()),
      ],
    );
  }
}
