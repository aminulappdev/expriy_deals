class OrderModel {
    OrderModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final OrderItemModel? data;

    factory OrderModel.fromJson(Map<String, dynamic> json){ 
        return OrderModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : OrderItemModel.fromJson(json["data"]),
        );
    }

}

class OrderItemModel {
    OrderItemModel({
        required this.user,
        required this.author,
        required this.product,
        required this.totalPrice,
        required this.discount,
        required this.quantity,
        required this.status,
        required this.isPaid,
        required this.billingDetails,
        required this.isDeleted,
        required this.id,
        required this.dataId,
        required this.tnxId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? user;
    final String? author;
    final String? product;
    final double? totalPrice;
    final int? discount;
    final int? quantity;
    final String? status;
    final bool? isPaid;
    final BillingDetails? billingDetails;
    final bool? isDeleted;
    final String? id;
    final String? dataId;
    final String? tnxId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory OrderItemModel.fromJson(Map<String, dynamic> json){ 
        return OrderItemModel(
            user: json["user"],
            author: json["author"],
            product: json["product"],
            totalPrice: json["totalPrice"],
            discount: json["discount"],
            quantity: json["quantity"],
            status: json["status"],
            isPaid: json["isPaid"],
            billingDetails: json["billingDetails"] == null ? null : BillingDetails.fromJson(json["billingDetails"]),
            isDeleted: json["isDeleted"],
            id: json["_id"],
            dataId: json["id"],
            tnxId: json["tnxId"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class BillingDetails {
    BillingDetails({
        required this.address,
        required this.city,
        required this.state,
        required this.zipCode,
        required this.country,
    });

    final String? address;
    final String? city;
    final String? state;
    final String? zipCode;
    final String? country;

    factory BillingDetails.fromJson(Map<String, dynamic> json){ 
        return BillingDetails(
            address: json["address"],
            city: json["city"],
            state: json["state"],
            zipCode: json["zipCode"],
            country: json["country"],
        );
    }

}
