import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel();
  DateTime createAt = DateTime.now();
  DateTime updateAt = DateTime.now();
  late String docId;
  late String userName;
  late String email;

  // UserModel.fromMap(Map<String, dynamic>) {
  //   this.docId = map[UserField.docId];
  //   this.userName = map[UserField.userName];
  //   this.email = map[UserField.email];
  //   this.updateAt = map[UserField.updateAt];
  //   this.updateAt = map[UserField.updateAt];

  //   // DartのDateに変換
  //   final originCreatedAt = map[UserField.createAt];
  //   if (originCreatedAt is Timestamp) {
  //     createAt = originCreatedAt.toDate();
  //   }

  //   // DartのDateに変換
  //   final originUpdateAt = map[UserField.updateAt];
  //   if (originUpdateAt is Timestamp) {
  //     updateAt = originUpdateAt.toDate();
  //   }
  // }

  // Firestore用のMapに変換
  Map<String, dynamic> toMap() {
    return {
      UserField.docId: docId,
      UserField.userName: userName,
      UserField.email: email,
      UserField.createAt: createAt,
      UserField.updateAt: updateAt,
    };
  }
}

class UserField {
  static const userName = "userName";
  static const docId = "docId";
  static const email = "email";
  static const createAt = "createAt";
  static const updateAt = "updateAt";
}
