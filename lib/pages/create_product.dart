import 'dart:io';

import 'package:flutter/material.dart';
import 'package:navigation_practice/Widgets/form_input/imagegetter.dart';
import 'package:navigation_practice/Widgets/form_input/location_inputform.dart';
import 'package:navigation_practice/models/location_data.dart';
import 'package:navigation_practice/scoped_models/main_scoped.dart';
import '../models/product_type.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateAndEditProductPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateAndEditProductPageState();
  }
}

class _CreateAndEditProductPageState extends State<CreateAndEditProductPage> {
  TextEditingController textEditingControllerTitle = TextEditingController();
  TextEditingController textEditingControllerDesription =
      TextEditingController();
  TextEditingController textEditingControllerPrice = TextEditingController();

  final Product _formData = Product(
      imageURL: null,
      title: "",
      description: "",
      price: null,
      locationData: null);
  File _image;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Widget _buildTitleTextFormField(MainScopedModel model) {
    if (model.selectedProduct == null &&
        textEditingControllerTitle.text.trim() == '') {
      textEditingControllerTitle.text = '';
    } else if (model.selectedProduct != null &&
        textEditingControllerTitle.text.trim() == '') {
      textEditingControllerTitle.text = model.selectedProduct.title;
    } else if (model.selectedProduct != null &&
        textEditingControllerTitle.text.trim() != '') {
      textEditingControllerTitle.text = textEditingControllerTitle.text;
    } else if (model.selectedProduct == null &&
        textEditingControllerTitle.text.trim() != '') {
      textEditingControllerTitle.text = textEditingControllerTitle.text;
    } else {
      textEditingControllerTitle.text = '';
    }
    return (TextFormField(
      controller: textEditingControllerTitle,
      validator: (String value) {
        print("ddikjsoooooooooooooooooooooooooooooooooooooooovalidator tilte" +
            value);

        if ((value.trim().isEmpty) || (value.length < 5)) {
          return "Title is required and should be atleast 5 characters";
        }
      },
      onSaved: (String value) {
        _formData.title = value;
      },
      decoration: InputDecoration(labelText: "Product Title"),
      keyboardType: TextInputType.text,
    ));
  }

  Widget _buildDescriptionTextFormField(MainScopedModel model) {
    if (model.selectedProduct == null &&
        textEditingControllerDesription.text.trim() == '') {
      textEditingControllerDesription.text = '';
    } else if (model.selectedProduct != null &&
        textEditingControllerDesription.text.trim() == '') {
      textEditingControllerDesription.text = model.selectedProduct.description;
    }
    return (TextFormField(
      controller: textEditingControllerDesription,
      onSaved: (String value) {
        _formData.description = value;
      },
      validator: (String value) {
        if ((value.trim().isEmpty) || (value.length < 5)) {
          return "Description is required and should be atleast 5 characters";
        }
      },
      decoration: InputDecoration(
        labelText: "Product Description",
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 4,
    ));
  }

  Widget _buildPriceTextFormField(MainScopedModel model) {
    if (model.selectedProduct == null &&
        textEditingControllerPrice.text.trim() == '') {
      textEditingControllerPrice.text = '';
    } else if (model.selectedProduct != null &&
        textEditingControllerPrice.text.trim() == '') {
      textEditingControllerPrice.text = model.selectedProduct.price.toString();
    }
    return (TextFormField(
      controller: textEditingControllerPrice,
      onSaved: (String value) {
        _formData.price = double.parse(value.replaceFirst(",", "."));
      },
      validator: (String value) {
        if ((value.trim().isEmpty) ||
            !(RegExp(r"^([0-9]+\.?[0-9]*)$")
                .hasMatch(value.replaceFirst(",", ".")))) {
          return "Price is required and should be a number";
        }
        if(_image==null && model.selectedProduct==null){
          return "pick an image";
        }
      },
      decoration: InputDecoration(labelText: "Product Price"),
      keyboardType: TextInputType.number,
    ));
  }

  void setImage(File image) {
    _image = image;
  }

  Widget _buildButtonOrProgressBar() {
    return ScopedModelDescendant<MainScopedModel>(
      builder: (BuildContext context, Widget child, MainScopedModel model) {
        if (model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return RaisedButton(
            onPressed: () {
              print("ddikjsoooooooooooooooooooooooooooooooooooooooo" +
                  _formData.title);

              if (_formKey.currentState.validate() && (_image != null || model.selectedProduct != null)) {
                _formKey.currentState.save();

                print("ddikjsoooooooooooooooooooooooooooooooooooooooo" +
                    _formData.title);
                if (model.selectedProductID == null) {
                  _formData.userID = model.authenticatedUser.id;
                  _formData.email = model.authenticatedUser.email;
                  model
                      .addProduct(
                          _formData.title,
                          _formData.description,
                          _formData.price,
                          _formData.userID,
                          _formData.email,
                          _formData.imageURL,
                          _formData.locationData,
                          _image)
                      .then((bool success) {
                    if (success) {
                      textEditingControllerDesription.text = null;
                      textEditingControllerPrice.text = null;
                      textEditingControllerTitle.text = null;
                      Navigator.pushReplacementNamed(context, '/').then((_) {
                        model.selectedProductID = null;
                      });
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Something went wrong"),
                              content: Text(
                                  "Please check your network connectivity"),
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
                } else {
                  _formData.isFavourite = model.selectedProduct.isFavourite;
                  _formData.email = model.authenticatedUser.email;
                  _formData.userID = model.authenticatedUser.id;
                  model
                      .updateProduct(
                          _formData.title,
                          _formData.description,
                          _formData.price,
                          _formData.userID,
                          _formData.email,
                          _formData.imageURL,
                          _formData.locationData,
                          _image)
                      .then((bool success) {
                    if (success) {
                      textEditingControllerDesription.text = null;
                      textEditingControllerPrice.text = null;
                      textEditingControllerTitle.text = null;
                      Navigator.pushReplacementNamed(context, "/");
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Something went wrong!"),
                              content: Text(
                                  "Please check your network connectivity"),
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
              }
            },
            child: Text(
              "Save",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            color: Theme.of(context).accentColor,
          );
        }
      },
    );
  }

  void setLocation(LocationData locationData) {
    _formData.locationData = locationData;
    print(locationData.address +
        locationData.latitude.toString() +
        locationData.longitude.toString());
  }

//########################################BUILD###########################################
  @override
  Widget build(BuildContext context) {
    final double devWidth = MediaQuery.of(context).size.width;
    final double targetWidth =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? devWidth * 0.9
            : devWidth * 0.7;
    final double targetPadding = devWidth - targetWidth;
    final Widget pageContent = ScopedModelDescendant<MainScopedModel>(
      builder: (BuildContext context, Widget child, MainScopedModel model) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: targetPadding / 3, vertical: 10.0),
              children: <Widget>[
                ImagePickingButton(
                  setImage,
                  selProduct: model.selectedProduct,
                ),
                _buildTitleTextFormField(model),
                _buildDescriptionTextFormField(model),
                _buildPriceTextFormField(model),
                LocationFormField(
                  setLocation,
                  product: model.selectedProduct,
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: _buildButtonOrProgressBar(),
                )
              ],
            ),
          ),
        );
      },
    );

    return ScopedModelDescendant<MainScopedModel>(
      builder: (BuildContext context, Widget child, MainScopedModel model) {
        return model.selectedProductID != null
            ? Scaffold(
                appBar: AppBar(
                  title: Text("Edit Text"),
                ),
                body: pageContent,
              )
            : pageContent;
      },
    );
  }
}
