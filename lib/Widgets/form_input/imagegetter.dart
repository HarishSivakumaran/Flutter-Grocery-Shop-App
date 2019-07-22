import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../models/product_type.dart';

class ImagePickingButton extends StatefulWidget {
  Function setImage;
  Product selProduct;
  ImagePickingButton(this.setImage, {this.selProduct});
  @override
  State<StatefulWidget> createState() {
    return _ImagePickingButton();
  }
}

class _ImagePickingButton extends State<ImagePickingButton> {
  File _image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _image == null
            ? widget.selProduct == null
                ? Image.asset("assets/auth_bg.jpeg")
                : Image.network(
                    widget.selProduct.imageURL,
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )
            : Image.file(
                _image,
                fit: BoxFit.cover,
                height: 300,
                width: MediaQuery.of(context).size.width,
              ),
        OutlineButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 150.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Image Picker",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.blue),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        FlatButton(
                          onPressed: () {
                            ImagePicker.pickImage(
                              source: ImageSource.camera,
                              maxWidth: 400,
                            ).then((File image) {
                              setState(() {
                                _image = image;
                                widget.setImage(image);
                              });
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Open Camera"),
                        ),
                        FlatButton(
                          onPressed: () {
                            ImagePicker.pickImage(
                              source: ImageSource.gallery,
                              maxWidth: 400,
                            ).then((File image) {
                              setState(() {
                                _image = image;
                                widget.setImage(image);
                              });
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Open Gallery"),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.camera_alt),
              SizedBox(
                width: 7.0,
              ),
              Text("Pick an image"),
            ],
          ),
        ),
      ],
    );
  }
}
