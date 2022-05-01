import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vilogs/styles/colors_app.dart';
import '/data/models/user.dart' as UserModel;

class SignUpDAO extends ChangeNotifier {
  SignUpDAO({this.user});

  EmailAuth emailAuth = new EmailAuth(
    sessionName: "sessionName",
  );

  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  final UserModel.User? user;
  String? verificationId;

  Future<void> signUp(String? UserID) async {
    if (user != null && UserID != null)
      await collection.doc(user?.email).set(user!.toJson());

    return Future.value();
  }

  Future<void> createUser() async {
    try {
      if (user != null) {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
                email: user!.email!, password: user!.password!);
        if (userCredential.user != null) await signUp(userCredential.user!.uid);
      }
    } catch (e) {
      print("Error 00000000000000001");
    }
    return Future.value();
  }

  Future<bool> verifyEmail(BuildContext context) async {
    try {
      // return true;
      if (user != null && !(await checkIfExistEmail()))
        return await sendOtp();
      else {
        final snackBar = SnackBar(
          content: Text('exist-user'.tr(),
              style: Theme.of(context).textTheme.headline1),
          backgroundColor: ColorsApp.yellow,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  Future<bool> sendOtp() async {
    try {
      // return true;
      if (user != null && user!.email != null)
        return await emailAuth.sendOtp(
            recipientMail: user!.email!, otpLength: 4);
      else
        return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> verifyCode(String code) async {
    try {
      bool status = await emailAuth.validateOtp(
          recipientMail: user!.email!, userOtp: code);
      return status;
    } catch (_) {
      return false;
    }
  }

  Future<bool> checkIfExistEmail() async {
    try {
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(user!.email!);
      if (list.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return true;
    }
  }

  Future<bool> resetPassword() async {
    if (user != null && user!.email != null && (await checkIfExistEmail()))
      return await sendOtp();
    else
      return false;
  }

  Future<void> changePassword() async {
    await collection.doc(user?.email).update({"password": user?.password});

    Future.value();
  }

  Future<void> updateUser(UserModel.User user) async {
    await collection.doc(user.email).update(user.toJson());
    return Future.value();
  }
}
