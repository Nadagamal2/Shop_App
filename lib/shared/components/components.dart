import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/layout/shop_app/cubit/cubit.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/styles/colors.dart';

Widget defultButtun ({
    double width =double.infinity,

   Color background=Colors.blue ,
  bool isUpperCase=true,
  double radius=5.0,
  required void Function()?  function,
  required String text,
})=> Container(
  width: width,


  child: MaterialButton(
    onPressed : function ,
    child: Text(
      isUpperCase? text.toUpperCase():text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),

  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius), color:  background,

  ),

);
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType Type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
    void Function()?  onTap,
  required String? Function (String?)? validate,
  required String lable,
  bool isPassword=false,
  required IconData prefix ,
  void Function()? suffixPressed,
  bool isClickable =true,
  IconData? suffix,
})=> TextFormField(
controller: controller,
keyboardType: Type,
  obscureText: isPassword,
onFieldSubmitted:onSubmit,
onChanged:onChange,
onTap: onTap,
enabled:isClickable ,
validator: validate,
decoration: InputDecoration(
labelText: lable ,labelStyle: TextStyle(fontWeight: FontWeight.bold,),
prefixIcon: Icon(
prefix,
),
  suffixIcon: suffix!= null ? IconButton(
    onPressed: suffixPressed,
    icon: Icon(
      suffix,
    ),
  ):null,
border: OutlineInputBorder(

),
),
);
Widget buildTaskItem(Map model,context)=> Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        CircleAvatar(
  
          radius: 40.0,
  
          child: Text(
  
            '${ model['time']}',
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        Expanded(
  
          child: Column(
  
            mainAxisSize: MainAxisSize.min,
  
            crossAxisAlignment: CrossAxisAlignment.start,
  
            children: [
  
              Text(
  
                '${ model['title']}',
  
                style: TextStyle(
  
                  fontSize: 18.0,
  
                  fontWeight: FontWeight.bold,
  
  
  
                ),
  
              ),
  
              Text(
  
                '${ model['date']}',
  
                style: TextStyle(
  
  
  
                  color: Colors.grey,
  
  
  
                ),
  
              ),
  
            ],
  
          ),
  
  
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        IconButton(
  
            onPressed: ()
  
            {
  
              AppCibit.get(context).updataData(status: 'Done', id: model['id'],);
  
  
  
  
  
            },
  
            icon: Icon(
  
              Icons.check_box,
  
              color: Colors.green,
  
            ),
  
        ),
  
        IconButton(
  
          onPressed: ()
  
          {
  
            AppCibit.get(context).updataData(status: 'Archived', id: model['id'],);
  
  
  
          },
  
          icon: Icon(
  
            Icons.archive,
  
            color: Colors.black45,
  
          ),
  
        ),
  
  
  
      ],
  
    ),
  
  ),
  onDismissed: (direction){
    AppCibit.get(context).deleteData(id: model['id'],);
  },
);
Widget tasksBuilder ({
  required List<Map> tasks,
})=> ConditionalBuilder(
  condition: tasks.length>0,
  builder: (context)=> ListView.separated(
    itemBuilder: (context, index){return buildTaskItem(tasks[index],context);},
    separatorBuilder: (context, index)=>myDivider(),
    itemCount: tasks.length,
  ),
  fallback: (context)=>Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet, Please Add Some Tasks!',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);
Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
 void navigateTo(context,Widget)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)=> Widget,
  ),
);
void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context)=> widget,
    ),
     (Route<dynamic> route) => false,

    );
Widget defaulTextButtom({
  required void Function() function,
  required String text,
 v
})=> TextButton(
  onPressed: function,
  child: Text(
    text.toUpperCase(),
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
);


void showToast({
  required String text,
  required ToastStates state,



})=> Fluttertoast.showToast(
  msg:  text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor:chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastStates{SUCCESS,ERROR,WORNING}

Color ?chooseToastColor(ToastStates state)
{
  Color color;
switch(state)
{
  case ToastStates.SUCCESS:
    color= Colors.green;
    break;
  case ToastStates.ERROR:
    color= Colors.red;
    break;
  case ToastStates.WORNING:
    color= Colors.yellow;
    break;
}
return color;
}
Widget buildListProduct(  model,context,{bool isOldPrice=true,})=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model!.image),
              width: 120.0,
              height: 120.0,


            ),
            if(model!.discount!=0&& isOldPrice)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  'DISCOUNT',
                  style:TextStyle(
                    fontSize: 8.0,

                    color: Colors.white,

                  ) ,
                ),
              )
          ],
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model!.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  height: 1.1,

                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model!.price.toString(),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if(model!.discount!=0 &&isOldPrice)
                    Text(
                      model!.oldPrice.toString(),
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(

                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model!.id);

                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:ShopCubit.get(context).favorites[ model!.id]!
                            ?defaultColor
                            : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,

                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
