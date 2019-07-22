import 'package:navigation_practice/scoped_models/connected_productandusers_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MainScopedModel extends Model with ConnectedProUserScopedModel,UserScopedModel,ProductsScopedModel,UtilityScopedModel{

}  