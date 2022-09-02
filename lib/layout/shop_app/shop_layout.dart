import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_app/cubit/cubit.dart';
import 'package:shop/layout/shop_app/cubit/states.dart';
import 'package:shop/shared/components/components.dart';

import '../../modules/shop_app/search/search_screen.dart';

class ShopLayout extends StatelessWidget
{
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit =ShopCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text(
              'Shop App',
            ),
            actions: [IconButton(
                onPressed: (){
                  navigateTo(context, SearchScreen());

                },
                icon: Icon(Icons.search,)),
            ],
          ),
          body:cubit.bottomsSreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(

                icon: Icon(Icons.home,),
                label: 'Home',


              ),
              BottomNavigationBarItem(

                icon: Icon(Icons.apps,),
                label: 'Categories',


              ),
              BottomNavigationBarItem(

                icon: Icon(Icons.favorite,),
                label: 'Favorites',


              ),
              BottomNavigationBarItem(

                icon: Icon(Icons.settings,),
                label: 'Settings',


              ),
            
          ],

          ),

        );
      },
    );
  }
}
