import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/userModel.dart';

class UserService {
  Future<void> createInitUser(String uid, String userName, String email) {
    UserModel user = UserModel();
    print(uid);
    print(userName);
    print(email);

    user.docId = uid;
    user.userName = userName;
    user.email = email;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection("users").add(user.toMap());
  }

  Future<void> updateUserInfo(String uid, String userName, String email) {
    UserModel user = UserModel();
    print(uid);
    print(userName);
    print(email);

    user.docId = uid;
    user.userName = userName;
    user.email = email;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore
        .collection("users")
        .doc(uid)
        .set(user.toMap(), SetOptions(merge: true));
  }
}
