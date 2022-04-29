import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/data/models/user.dart' as UserModel;

class SignInDAO extends ChangeNotifier {
  final FirebaseAuth _firebaseInstance = FirebaseAuth.instance;
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  Future<UserModel.User?> signIn(String? email, String? password) async {
    UserModel.User? user;
    if (email != null && password != null)
     try{
       // await _firebaseInstance
       //     .signInWithEmailAndPassword(email: email, password: password);
         await collection.doc(email).get().then((value) {
           if ((value.data() as Map<String, dynamic>)["password"] == password) {
             user = UserModel.User.fromJson(value.data() as Map<String, dynamic>);
           }
       });
     }catch(e){
       return user;
     }
    else
      return user;
    return user;
  }
}
