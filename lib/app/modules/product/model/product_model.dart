class ProductModel {
    ProductModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final Data? data;

    factory ProductModel.fromJson(Map<String, dynamic> json){ 
        return ProductModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

}

class Data {
    Data({
        required this.data,
        required this.meta,
    });

    final List<ProductItemModel> data;
    final Meta? meta;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            data: json["data"] == null ? [] : List<ProductItemModel>.from(json["data"]!.map((x) => ProductItemModel.fromJson(x))),
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        );
    }

}

class ProductItemModel {
    ProductItemModel({
        required this.id,
        required this.images,
        required this.author,
        required this.name,
        required this.details,
        required this.category,
        required this.price,
        required this.quantity,
        required this.expiredAt,
        required this.discount,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final List<Image> images;
    final Author? author;
    final String? name;
    final String? details;
    final Category? category;
    final double? price;
    final int? quantity;
    final DateTime? expiredAt;
    final int? discount;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory ProductItemModel.fromJson(Map<String, dynamic> json){ 
        return ProductItemModel(
            id: json["_id"],
            images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
            author: json["author"] == null ? null : Author.fromJson(json["author"]),
            name: json["name"],
            details: json["details"],
            category: json["category"] == null ? null : Category.fromJson(json["category"]),
            price: json["price"],
            quantity: json["quantity"],
            expiredAt: DateTime.tryParse(json["expiredAt"] ?? ""),
            discount: json["discount"],
            isDeleted: json["isDeleted"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
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

class Category {
    Category({
        required this.id,
        required this.name,
        required this.banner,
    });

    final String? id;
    final String? name;
    final String? banner;

    factory Category.fromJson(Map<String, dynamic> json){ 
        return Category(
            id: json["_id"],
            name: json["name"],
            banner: json["banner"],
        );
    }

}

class Image {
    Image({
        required this.key,
        required this.url,
        required this.id,
    });

    final String? key;
    final String? url;
    final String? id;

    factory Image.fromJson(Map<String, dynamic> json){ 
        return Image(
            key: json["key"],
            url: json["url"],
            id: json["_id"],
        );
    }

}

class Meta {
    Meta({
        required this.page,
        required this.limit,
        required this.total,
        required this.totalPage,
    });

    final int? page;
    final int? limit;
    final int? total;
    final int? totalPage;

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
            page: json["page"],
            limit: json["limit"],
            total: json["total"],
            totalPage: json["totalPage"],
        );
    }

}
