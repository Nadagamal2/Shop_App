import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/shop_app/login_model.dart';
import 'package:shop/modules/shop_app/register/cubit/states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';



class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit():super(ShopRegisterIntailState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  late ShopRegisterModel registerModel ;
  void userRegister({
      required String name,  
      required String email,
      required String password,
      required String phone,
})
  {       
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data:
        {    'name':name,
          'email':email,

          'password':password,
          'phone':phone,

        }).then((value)
    {
          print(value.data);
          registerModel=  ShopRegisterModel.fromJason(value.data);


          emit(ShopRegisterSuccessState(registerModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });

  }

IconData suffix=Icons.visibility_outlined;
  bool isPassword =true;
  void changePasswordVisibility(){
    isPassword=!isPassword;

    suffix=isPassword ?Icons.visibility_outlined:Icons.visibility_off_outlined;

emit(ShopRegisterChangePasswordVisibilityState());
  }
}