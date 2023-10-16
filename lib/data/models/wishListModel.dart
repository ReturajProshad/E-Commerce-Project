class wishListModel {
  String? msg;
  List<wishData>? data;

  wishListModel({this.msg, this.data});

  wishListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <wishData>[];
      json['data'].forEach((v) {
        data!.add(wishData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class wishData {
  int? id;
  String? email;
  int? productId;
  String? createdAt;
  String? updatedAt;
  Null? product;

  wishData(
      {this.id,
      this.email,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.product});

  wishData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}
