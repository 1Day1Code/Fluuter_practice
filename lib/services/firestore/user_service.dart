import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/userModel.dart';

class UserService {
  Future<Map> getUserByUid(String uid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentSnapshot doc =
        await firestore.collection('users').doc(uid).get();
    Map ue = doc.data() as Map<String, dynamic>;
    return ue;
  }

  Future<void> createInitUser(
      String userId, String userName, String email) async {
    UserModel user = UserModel();
    user.userName = userName;
    user.email = email;
    user.docId = userId;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // DocumentReference docRef =
    //     await firestore.collection("users").add(user.toMap());
    // print(docRef.id);
    // DocumentReference updateRef =
    //     await firestore.collection("users").doc(docRef.id);

    // user.docId = userId;
    // print(userId);
    final DocumentReference doc = firestore.collection('users').doc(userId);
    await doc.set(user.toMap(), SetOptions(merge: true));
  }

  Future<void> updateUserInfo(String uid, String userName, String email) {
    UserModel user = UserModel();
    // print(uid);
    // print(userName);

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
