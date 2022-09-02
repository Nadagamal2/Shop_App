import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_app/cubit/cubit.dart';
import 'package:shop/layout/shop_app/cubit/states.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
 var nameController=TextEditingController();
 var emailController=TextEditingController();
 var phoneController=TextEditingController();


 @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(

      listener: (context,state)
      {

      },
      builder: (context,state)
      {
        var model=ShopCubit.get(context).userModel;

        nameController.text= model!.data!.name;
        emailController.text=model.data!.email;
        phoneController.text=model.data!.phone;

        return  ConditionalBuilder(
          condition: ShopCubit.get(context).userModel!=null,
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),

                  defaultFormField(
                    controller: nameController,
                    Type: TextInputType.name,
                    validate: (String? value)
                    {
                      if(value!.isEmpty){
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    lable: 'Name',
                    prefix: Icons.person,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  defaultFormField(
                    controller: emailController,
                    Type: TextInputType.emailAddress,
                    validate: (String? value)
                    {
                      if(value!.isEmpty){
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    lable: 'Email Address',
                    prefix: Icons.email,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  defaultFormField(
                    controller: phoneController,
                    Type: TextInputType.phone,
                    validate: (String? value)
                    {
                      if(value!.isEmpty){
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    lable: 'Phone',
                    prefix: Icons.phone,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defultButtun(
                      function: (){
                        if(formKey.currentState!.validate()){
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }

                      },
                      text: 'Update'),
                  SizedBox(
                    height: 20.0,
                  ),
                  defultButtun(
                      function: (){
                        sighOut(context);
                      },
                      text: 'Logout'),
                ],
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
