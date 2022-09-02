class ChangeFavoritesModel{
  bool? status;
  dynamic message;
  ChangeFavoritesModel.fromjson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];

  }

}