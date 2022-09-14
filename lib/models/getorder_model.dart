class GetOrdersModel {
  bool? status;
  OrderDetailsData? data;

  GetOrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new OrderDetailsData.fromJson(json['data']) : null;
  }
}

  class OrderDetailsData {
   int? id;
   dynamic cost;
   dynamic vat;
   dynamic total;
  String? date;
  String? status;
  OrderDetailsData.fromJson(Map<String, dynamic> json) {
  id = json["id"];
  cost = json["cost"];
  vat = json["vat"];
  total = json["total"];
  date = json["date"];
  status = json["status"];
  }}

  class AddOrderModel {
  late bool status;
  late String message;
  AddOrderModel.fromJson(Map<String, dynamic> json) {
  status = json['status'];
  message = json['message'];
  }
  }
