import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel();
  DateTime createAt = DateTime.now();
  DateTime updateAt = DateTime.now();
  late String docId;
  late String userName;
  late String email;

  UserModel.fromMap(Map<String, dynamic> map) {
    docId = map[UserField.docId];
    userName = map[UserField.userName];
    email = map[UserField.email];

    // DartのDateに変換
    final originCreatedAt = map[UserField.createAt];
    if (originCreatedAt is Timestamp) {
      createAt = originCreatedAt.toDate();
    }

    // DartのDateに変換
    final originUpdateAt = map[UserField.updateAt];
    if (originUpdateAt is Timestamp) {
      updateAt = originUpdateAt.toDate();
    }
  }

  // Firestore用のMapに変換
  Map<String, dynamic> toMap() {
    return {
      UserField.docId: this.docId,
      UserField.userName: this.userName,
      UserField.email: this.email,
      UserField.createAt: this.createAt,
      UserField.updateAt: this.updateAt,
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
