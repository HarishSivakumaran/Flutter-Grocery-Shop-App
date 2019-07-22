import 'package:flutter/material.dart';
import 'package:navigation_practice/pages/products_page.dart';
import 'package:navigation_practice/scoped_models/main_scoped.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/rendering.dart';
import '../Widgets/teddybearwidgets/signin_button.dart';
import '../Widgets/teddybearwidgets/teddy_controller.dart';
import '../Widgets/teddybearwidgets/tracking_text_input.dart';

// class AuthPage extends StatefulWidget {
//   AuthPage();

//   @override
//   State<StatefulWidget> createState() {
//     return _AuthPageState();
//   }
// }

// class _AuthPageState extends State<AuthPage> {
//   final Map<String, dynamic> _authFormData = {
//     "email": null,
//     "password": null,
//     "termsandconditions": false,
//   };

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   Widget _buildEmailTextFormField() => TextFormField(
//         decoration: InputDecoration(
//           errorStyle: TextStyle(
//               color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16.0),
//           labelText: "E-mail",
//           filled: true,
//           fillColor: Colors.white,
//         ),
//         validator: (String value) {
//           if (value.trim().isEmpty ||
//               !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
//                   .hasMatch(value)) {
//             return "E-mail is invalid";
//           }
//         },
//         keyboardType: TextInputType.emailAddress,
//         onSaved: (String value) {
//           setState(() {
//             _authFormData["email"] = value;
//           });
//         },
//       );

//   Widget _buildPasswdTextFormField() {
//     return (TextFormField(
//       decoration: InputDecoration(
//           errorStyle: TextStyle(
//               color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16.0),
//           labelText: "password",
//           filled: true,
//           fillColor: Colors.white),
//       keyboardType: TextInputType.text,
//       obscureText: true,
//       validator: (String value) {
//         if (value.trim().isEmpty || value.trim().length < 7) {
//           return "Password should be 7+ characters";
//         }
//       },
//       onSaved: (String value) {
//         setState(() {
//           _authFormData["password"] = value;
//         });
//       },
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double deviceWidth = MediaQuery.of(context).size.width;

//     final double targetWidth =
//         MediaQuery.of(context).orientation == Orientation.portrait
//             ? deviceWidth * 0.95
//             : deviceWidth * 0.7;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Authentication"),
//       ),
//       body: GestureDetector(
//         onTap: (){
//           FocusScope.of(context).requestFocus(FocusNode());
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/auth_bg.jpeg"),
//               fit: BoxFit.cover,
//               colorFilter: ColorFilter.mode(
//                 Colors.black.withOpacity(0.8),
//                 BlendMode.dstATop,
//               ),
//             ),
//           ),
//           padding: EdgeInsets.all(10.0),
//           child: Container(
//             alignment: Alignment.center,
//             child: SingleChildScrollView(
//               child: Container(
//                 width: targetWidth,
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       _buildEmailTextFormField(),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       _buildPasswdTextFormField(),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       SwitchListTile(
//                         title: Text(
//                           "Terms And Conditions",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onChanged: (bool value) {
//                           setState(() {
//                             _authFormData["termsandconditions"] = value;
//                           });
//                         },
//                         value: _authFormData["termsandconditions"],
//                       ),
//                       RaisedButton(
//                         color: Colors.amber,
//                         onPressed: () {
//                           if (_formKey.currentState.validate() && _authFormData["termsandconditions"]) {
//                             _formKey.currentState.save();
//                             Navigator.pushReplacementNamed(context, '/product');
//                           }
//                         },
//                         child: Text(
//                           'Login',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

enum AuthMode { Login, Signup }

class AuthPage extends StatefulWidget {
  AuthPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthMode _authMode = AuthMode.Login;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TeddyController _teddyController;
  final TextEditingController passwordTextEditingContr =
      new TextEditingController();
  final TextEditingController emailTextEditingContr =
      new TextEditingController();
  final TextEditingController confimpasswordTextEditingContr =
      new TextEditingController();
  final Map<String, dynamic> _authFormData = {
    "email": null,
    "password": null,
    "termsandconditions": false,
  };
  @override
  initState() {
    _teddyController = TeddyController();
    super.initState();
  }

  Widget _buildConfirmPasswdTextFormField() {
    return (TrackingTextInput(
      textInputType: TextInputType.text,
      validationFunction: (String value) {
        if (passwordTextEditingContr.text != value) {
          return "Passwords do not match";
        }
      },
      onSaved: (String value) {},
      label: "confirm Password",
      isObscured: true,
      onCaretMoved: (Offset caret) {
        _teddyController.coverEyes(caret != null);
        _teddyController.lookAt(null);
      },
      textEditingController: confimpasswordTextEditingContr,
    ));
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Container(
              decoration: BoxDecoration(
                // Box decoration takes a gradient

                image: DecorationImage(
                  image: AssetImage("assets/auth_bg.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            )),
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: devicePadding.top + 50.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 200,
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: FlareActor(
                            "assets/Teddy.flr",
                            shouldClip: false,
                            alignment: Alignment.bottomCenter,
                            fit: BoxFit.contain,
                            controller: _teddyController,
                          )),
                      Form(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  TrackingTextInput(
                                      validationFunction: (String value) {
                                        if (value.trim().isEmpty ||
                                            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                .hasMatch(value)) {
                                          return "Email is invalid";
                                        }
                                      },
                                      textEditingController:
                                          emailTextEditingContr,
                                      onSaved: (String value) {
                                        _authFormData["email"] = value;
                                      },
                                      label: "Email",
                                      textInputType: TextInputType.emailAddress,
                                      hint: "What's your email address?",
                                      onCaretMoved: (Offset caret) {
                                        _teddyController.lookAt(caret);
                                      }),
                                  TrackingTextInput(
                                    validationFunction: (String value) {
                                      if (value.trim().isEmpty ||
                                          value.trim().length < 6) {
                                        return "Password should be 6+ characters";
                                      }
                                    },
                                    onSaved: (String value) {
                                      _authFormData["password"] = value;
                                    },
                                    label: "Password",
                                    hint: "Try 'bears'...",
                                    isObscured: true,
                                    textEditingController:
                                        passwordTextEditingContr,
                                    textInputType: TextInputType.text,
                                    onCaretMoved: (Offset caret) {
                                      _teddyController.coverEyes(caret != null);
                                      _teddyController.lookAt(null);
                                    },
                                    onTextChanged: (String value) {
                                      _teddyController.setPassword(value);
                                    },
                                  ),
                                  _authMode == AuthMode.Signup
                                      ? _buildConfirmPasswdTextFormField()
                                      : Container(),
                                  FlatButton(
                                    child: Text(
                                        "Switch to ${_authMode == AuthMode.Login ? "SignUp" : "Login"}"),
                                    onPressed: () {
                                      setState(() {
                                        _authMode = _authMode == AuthMode.Login
                                            ? AuthMode.Signup
                                            : AuthMode.Login;
                                      });
                                    },
                                  ),
                                  SwitchListTile(
                                    title: Text(
                                      "Accept Terms & Conditions",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onChanged: (bool value) {
                                      setState(() {
                                        _authFormData["termsandconditions"] =
                                            value;
                                      });
                                    },
                                    value: _authFormData["termsandconditions"],
                                  ),
                                  ScopedModelDescendant<MainScopedModel>(
                                    builder: (BuildContext context,
                                        Widget child, MainScopedModel model) {
                                      return model.isLoading
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : SigninButton(
                                              child: Text(
                                                  _authMode == AuthMode.Login
                                                      ? "Login"
                                                      : "SignUp",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "RobotoMedium",
                                                      fontSize: 16,
                                                      color: Colors.white)),
                                              onPressed: () {
                                                _teddyController
                                                    .submitPassword();
                                                if (_formKey.currentState
                                                        .validate() &&
                                                    _authFormData[
                                                        "termsandconditions"]) {
                                                  if (_authMode ==
                                                      AuthMode.Login) {
                                                    _formKey.currentState
                                                        .save();
                                                    model
                                                        .login(
                                                            email:
                                                                _authFormData[
                                                                    "email"],
                                                            password:
                                                                _authFormData[
                                                                    "password"])
                                                        .then((Map<String,
                                                                dynamic>
                                                            authResult) {
                                                      if (authResult[
                                                          "success"]) {
                                                        Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                "/");
                                                      } else {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                actions: <
                                                                    Widget>[
                                                                  FlatButton(
                                                                    child: Text(
                                                                        "Okay"),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  )
                                                                ],
                                                                title: Text(
                                                                    "Error has occured"),
                                                                content: Text(
                                                                    authResult[
                                                                        "message"]),
                                                              );
                                                            });
                                                      }
                                                    });
                                                  } else {
                                                    _formKey.currentState
                                                        .save();

                                                    model
                                                        .signup(
                                                            _authFormData[
                                                                "email"],
                                                            _authFormData[
                                                                "password"])
                                                        .then((Map<String,
                                                                dynamic>
                                                            authResult) {
                                                      if (authResult[
                                                          "success"]) {
                                                        Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                "/");
                                                      } else {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                actions: <
                                                                    Widget>[
                                                                  FlatButton(
                                                                    child: Text(
                                                                        "Okay"),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  )
                                                                ],
                                                                title: Text(
                                                                    "Error has occured"),
                                                                content: Text(
                                                                    authResult[
                                                                        "message"]),
                                                              );
                                                            });
                                                      }
                                                    });
                                                  }
                                                }
                                              });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
