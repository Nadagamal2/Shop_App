import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_app/shop_layout.dart';
import 'package:shop/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop/modules/shop_app/login/cubit/states.dart';
import 'package:shop/modules/shop_app/register/shop_register_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/local/cashe_helper.dart';


class ShopLoginScreen extends StatelessWidget
{
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();


    return BlocProvider(
      create: (BuildContext context)  =>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status!)
            {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CasheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data!.token,
              ).then((value) {
                token=state.loginModel.data!.token;
                navigateAndFinish(context, ShopLayout(),);
              });

            }else

            {
              print(state.loginModel.message);
              showToast(
                text: "${state.loginModel.message}",
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),

                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,

                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          Type: TextInputType.emailAddress,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'please enter your email address';
                            }
                          },
                          lable: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          Type: TextInputType.visiblePassword,
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixPressed: (){
                            ShopLoginCubit.get(context).changePasswordVisibility();

                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,

                          onSubmit: (value){
                            if( formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );

                            }

                          },
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'password is too short';
                            }
                          },
                          lable: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition:state is! ShopLoginLoadingState ,
                          builder: (context)=>defultButtun(
                            function: (){
                              if( formKey.currentState!.validate()){
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );

                              }

                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback:(context)=>Center(child: CircularProgressIndicator()) ,

                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            defaulTextButtom(
                              function:(){
                                navigateTo(context, ShopRegisterScreen());

                              },
                              text: 'register',
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          );
        },
      ),
    );
  }
}
