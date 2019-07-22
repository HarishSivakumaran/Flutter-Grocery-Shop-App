import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_practice/pages/product_admin.dart';
import 'package:navigation_practice/pages/product_detail_page.dart';
import 'package:navigation_practice/pages/products_page.dart';
import 'package:flutter/rendering.dart';
import 'package:navigation_practice/scoped_models/main_scoped.dart';
import './models/product_type.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:map_view/map_view.dart';

import './pages/auth_page.dart';

void main() {
  debugPaintSizeEnabled = false;
  MapView.setApiKey("AIzaSyDvquu68nN4ZWSELhAkMvj3VvFk-maR8zk");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainScopedModel model = MainScopedModel();
  bool _isAuthenticated = false;
  @override
  void initState() {
    super.initState();
    model.authAutomatic();
    model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainScopedModel>(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.blue,
            brightness: Brightness.light),
        routes: {
          "/": (BuildContext context) => ScopedModelDescendant<MainScopedModel>(
                builder: (BuildContext context, Widget child,
                    MainScopedModel model) {
                  return !_isAuthenticated ? AuthPage() : ProductsPage(model);
                },
              ),
          '/admin': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : ManageProducts(model),
          '/auth': (BuildContext context) => AuthPage(),
        },
        onGenerateRoute: (RouteSettings routeSettings) {
          if (!_isAuthenticated) {
            return MaterialPageRoute(
                builder: (BuildContext context) => AuthPage());
          }
          List<String> pathElement = routeSettings.name.split("/");
          if (pathElement[0] != '') return null;

          if (pathElement[1] == "product") {
            return MaterialPageRoute(
              builder: (BuildContext context) =>!_isAuthenticated
                      ? AuthPage(): ProductsDetailpage(
                    model.products[int.parse(pathElement[2])].id,
                  ),
            );
          }

          return null;
        },
        onUnknownRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute(
              builder: (BuildContext context) =>!_isAuthenticated
                      ? AuthPage(): ProductsPage(model));
        },
      ),
      model: model,
    );
  }
}
