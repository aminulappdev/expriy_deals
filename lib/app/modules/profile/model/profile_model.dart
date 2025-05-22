class ProfileModel {
    ProfileModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final ProfileData? data;

    factory ProfileModel.fromJson(Map<String, dynamic> json){ 
        return ProfileModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
        );
    }

}

class ProfileData {
    ProfileData({
        required this.verification,
        required this.id,
        required this.status,
        required this.name,
        required this.email,
        required this.phoneNumber,
        required this.gender,
        required this.dateOfBirth,
        required this.loginWth,
        required this.expireAt,
        required this.profile,
        required this.document,
        required this.role,
        required this.address,
        required this.isDeleted,
        required this.balance,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final Verification? verification;
    final String? id;
    final String? status;
    final String? name;
    final String? email;
    final dynamic phoneNumber;
    final dynamic gender;
    final dynamic dateOfBirth;
    final String? loginWth;
    final dynamic expireAt;
    final String? profile;
    final dynamic document;
    final String? role;
    final dynamic address;
    final bool? isDeleted;
    final int? balance;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory ProfileData.fromJson(Map<String, dynamic> json){ 
        return ProfileData(
            verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
            id: json["_id"],
            status: json["status"],
            name: json["name"],
            email: json["email"],
            phoneNumber: json["phoneNumber"],
            gender: json["gender"],
            dateOfBirth: json["dateOfBirth"],
            loginWth: json["loginWth"],
            expireAt: json["expireAt"],
            profile: json["profile"],
            document: json["document"],
            role: json["role"],
            address: json["address"],
            isDeleted: json["isDeleted"],
            balance: json["balance"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Verification {
    Verification({
        required this.otp,
        required this.status,
    });

    final int? otp;
    final bool? status;

    factory Verification.fromJson(Map<String, dynamic> json){ 
        return Verification(
            otp: json["otp"],
            status: json["status"],
        );
    }

}
