class ShopRegisterModel
{
    bool? status;
    String? message;
    UserData? data;
  ShopRegisterModel.fromJason(Map<String,dynamic> json)
   {

    status=json['status'];
    message=json['message'];
    data=(json['data']!=null ?UserData.fromJason(json['data']) : null);

  }

}
class  UserData{
    int? id;
    dynamic name;
    dynamic email;
    dynamic phone;
    String? image;
    int? points;
    int? credit;
    dynamic token;
  // UserData({
  //   required this.id,
  //   required this.name,
  //   required this.email,
  //   required this.phone,
  //   required this.image,
  //   required this.points,
  //   required this.credit,
  //   required this.token,
  // });
  //named constructor
  UserData.fromJason(Map<String,dynamic> json){

id=json['id'];
name=json['name'];
email=json['email'];
phone=json['phone'];
image=json['image'];
points=json['points'];
credit=json['credit'];
token=json['token'];
  }


}