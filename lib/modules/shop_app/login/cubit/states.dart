
import 'package:shop/models/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginIntailState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates{
  final ShopRegisterModel loginModel;


  ShopLoginSuccessState(this.loginModel);}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;

  ShopLoginErrorState(this.error);
}
class ShopChangePasswordVisibilityState extends ShopLoginStates{}

