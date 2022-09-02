
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_app/cubit/states.dart';
import 'package:shop/models/shop_app/categories_model.dart';
import 'package:shop/models/shop_app/change_favorites_model.dart';
import 'package:shop/models/shop_app/favorites_model.dart';
import 'package:shop/models/shop_app/home_model.dart';
import 'package:shop/models/shop_app/login_model.dart';
import 'package:shop/modules/shop_app/categories/categories_screen.dart';
import 'package:shop/modules/shop_app/favorites/favorite_screen.dart';
import 'package:shop/modules/shop_app/products/products_screen.dart';
import 'package:shop/modules/shop_app/settings/setting_screen.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';


class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit():super (ShopInitialStates());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex =0;
List <Widget> bottomsSreens =
[
  ProductsScreen(),
  CategoriesScreen(),
  FavoritesScreen(),
  SettingsScreen(),
];
void changeBottom (int index)
{
 currentIndex=index;
 emit(ShopChangeBottomNavStates());
}
HomeModel? homeModel;
Map<int?,bool?> favorites={};
void getHomeData (){
  emit(ShopLoadingHomeDataState());
  DioHelper.getData(
    url: HOME,
    token:token,
  ).then((value) {
    homeModel=HomeModel.fromJson(value?.data);
    // printFullText(homeModel!.data!.banners[0].image);
    // print (homeModel?.status);
    homeModel!.data!.products.forEach((element) {
      favorites.addAll({
        element.id:element.inFavorites,
      });
    });
    //print(favorites.toString());

     emit(ShopSuccessHomeDataState());
  }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
  });
}
  CategoriesModel? categoriesModel;
  void getCategories(){
     DioHelper.getData(
      url: GET_CATEGORIES,
      token:token,
    ).then((value) {
       categoriesModel=CategoriesModel.fromjson(value?.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites (int? product_id){
    favorites[product_id]= !favorites[product_id]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id':product_id
        },
      token: token,

    ).then((value) {
      changeFavoritesModel=ChangeFavoritesModel.fromjson(value.data);
     // print(value.data);
      if(!changeFavoritesModel!.status!){
        favorites[product_id]= !favorites[product_id]!;
      }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error){
      favorites[product_id]= !favorites[product_id]!;

      emit(ShopErrorChangeFavoritesState());
    });


  }

  FavoritesModel? favoritesModel;
  void getFavorites(){
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token:token,
    ).then((value) {
      favoritesModel=FavoritesModel.fromJson(value?.data);
      //printFullText(value!.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }
  ShopRegisterModel? userModel;
  void getUserData(){
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token:token,
    ).then((value) {
      userModel=ShopRegisterModel.fromJason(value?.data);
      //printFullText(userModel! .data!.name!);

      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGUserDataState());
    });
  }
  void updateUserData({
  required String name,
  required String email,
  required String phone,
}){
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token:token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value) {
      userModel=ShopRegisterModel.fromJason(value.data);
      //printFullText(userModel! .data!.name!);

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}