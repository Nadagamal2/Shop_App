


import 'package:shop/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cashe_helper.dart';

void sighOut (context){

  CasheHelper. removeData(key: 'token').then((value) {
    if(value!){
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}
void printFullText(String text){
final pattern=RegExp('.{1,800}');
pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}
dynamic token='';