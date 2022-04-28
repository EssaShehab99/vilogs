import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '/data/models/user.dart' as UserModel;

class SignUpDAO extends ChangeNotifier {
  SignUpDAO({this.user});

  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  final UserModel.User? user;
  String? verificationId;

  Future<void> signUp(String? UserID) async {
    if (user != null && UserID != null)
      await collection.doc(UserID).set(user!.toJson());

    return Future.value();
  }

  Future<void> createUser() async {
    if (user != null) {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: user!.email, password: user!.password!);
      await userCredential.user?.sendEmailVerification();
    }
    return Future.value();
  }

  Future<void> verificationEmail(
      {required String code, required Function onClick}) async {
    try {} catch (_) {}
  }

  Future<void> updateUser(UserModel.User user) async {
    // await collection.doc(user.phone).update(user.toJson());
    return Future.value();
  }
}
