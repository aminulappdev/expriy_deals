class ConfirmedPaymentResponseModel {
    ConfirmedPaymentResponseModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final ConfirmedPaymentResponseItemModel? data;

    factory ConfirmedPaymentResponseModel.fromJson(Map<String, dynamic> json){ 
        return ConfirmedPaymentResponseModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : ConfirmedPaymentResponseItemModel.fromJson(json["data"]),
        );
    }

}

class ConfirmedPaymentResponseItemModel {
    ConfirmedPaymentResponseItemModel({
        required this.id,
        required this.user,
        required this.author,
        required this.order,
        required this.status,
        required this.deliveryStatus,
        required this.trnId,
        required this.price,
        required this.paymentIntentId,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final Author? user;
    final Author? author;
    final String? order;
    final String? status;
    final String? deliveryStatus;
    final String? trnId;
    final double? price;
    final String? paymentIntentId;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory ConfirmedPaymentResponseItemModel.fromJson(Map<String, dynamic> json){ 
        return ConfirmedPaymentResponseItemModel(
            id: json["_id"],
            user: json["user"] == null ? null : Author.fromJson(json["user"]),
            author: json["author"] == null ? null : Author.fromJson(json["author"]),
            order: json["order"],
            status: json["status"],
            deliveryStatus: json["deliveryStatus"],
            trnId: json["trnId"],
            price: json["price"],
            paymentIntentId: json["paymentIntentId"],
            isDeleted: json["isDeleted"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Author {
    Author({
        required this.id,
        required this.name,
        required this.email,
        required this.phoneNumber,
        required this.profile,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? phoneNumber;
    final String? profile;

    factory Author.fromJson(Map<String, dynamic> json){ 
        return Author(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            phoneNumber: json["phoneNumber"],
            profile: json["profile"],
        );
    }

}
