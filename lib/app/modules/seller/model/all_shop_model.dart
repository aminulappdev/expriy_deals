class AllShopModel {
    AllShopModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final Data? data;

    factory AllShopModel.fromJson(Map<String, dynamic> json){ 
        return AllShopModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

}

class Data {
    Data({
        required this.meta,
        required this.data,
    });

    final Meta? meta;
    final List<AllShopItemModel> data;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<AllShopItemModel>.from(json["data"]!.map((x) => AllShopItemModel.fromJson(x))),
        );
    }

}

class AllShopItemModel {
    AllShopItemModel({
        required this.id,
        required this.name,
        required this.bannerColor,
        required this.author,
        required this.location,
        required this.isDeleted,
        required this.address,
        required this.description,
        required this.logo,
        required this.updatedAt,
        required this.banner,
        required this.openingDays,
        required this.openingHours,
    });

    final String? id;
    final String? name;
    final String? bannerColor;
    final Author? author;
    final Location? location;
    final bool? isDeleted;
    final String? address;
    final String? description;
    final String? logo;
    final DateTime? updatedAt;
    final String? banner;
    final String? openingDays;
    final String? openingHours;

    factory AllShopItemModel.fromJson(Map<String, dynamic> json){ 
        return AllShopItemModel(
            id: json["_id"],
            name: json["name"],
            bannerColor: json["bannerColor"],
            author: json["author"] == null ? null : Author.fromJson(json["author"]),
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            isDeleted: json["isDeleted"],
            address: json["address"],
            description: json["description"],
            logo: json["logo"],
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            banner: json["banner"],
            openingDays: json["openingDays"],
            openingHours: json["openingHours"],
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

class Location {
    Location({
        required this.type,
        required this.coordinates,
    });

    final String? type;
    final List<double> coordinates;

    factory Location.fromJson(Map<String, dynamic> json){ 
        return Location(
            type: json["type"],
            coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x)),
        );
    }

}

class Meta {
    Meta({
        required this.page,
        required this.limit,
        required this.total,
    });

    final int? page;
    final int? limit;
    final int? total;

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
            page: json["page"],
            limit: json["limit"],
            total: json["total"],
        );
    }

}
