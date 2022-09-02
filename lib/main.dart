
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_app/cubit/cubit.dart';
import 'package:shop/layout/shop_app/shop_layout.dart';
import 'package:shop/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shop/shared/styles/themes.dart';



import 'shared/bloc_observer.dart';
import 'shared/components/constants.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';
import 'shared/network/local/cashe_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(
        ()async {

      DioHelper.init();
      await CasheHelper.init();
      bool? isDark=CasheHelper.getData(key:'isDark');
      Widget widget;
      bool? onBoarding=CasheHelper.getData(key:'onBoarding');
      token =CasheHelper.getData(key:'token');
      print(token);
      if ( onBoarding!= null)
      {
        if(token!= null)widget=ShopLayout();
        else widget=ShopLoginScreen() ;
      }
      else
      {
        widget=OnBoardingScreen() ;
      }

      // Use cubits...
      runApp( MyApp(
        isDark: isDark,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}
class MyApp extends StatelessWidget
{
  //constructor
  //build----outomatic
  final bool? isDark;
  final Widget? startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [


        BlocProvider(create: (BuildContext context) =>AppCibit()..changeAppMode(fromShard: isDark),),
        BlocProvider(create: (BuildContext context) =>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),

      ],
      child: BlocConsumer<AppCibit,AppStates> (
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,



            darkTheme:darkTheme ,
            themeMode: ThemeMode.light,
            home:startWidget,
          );

        },
      ),
    );

  }

}