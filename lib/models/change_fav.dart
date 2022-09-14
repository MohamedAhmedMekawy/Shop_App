class ChangeFavorites{
   bool? status;
  String? message;

  ChangeFavorites.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}