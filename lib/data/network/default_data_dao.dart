import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vilogs/data/models/default_data.dart';
import 'package:vilogs/data/providers/default_data_manager.dart';
import 'package:vilogs/styles/colors_app.dart';
import '/data/models/user.dart' as UserModel;

class DefaultDataDAO extends ChangeNotifier {
  DefaultDataDAO(this._defaultDataManager);

  final DefaultDataManager? _defaultDataManager;

  final CollectionReference collectionVehicleBrand =
      FirebaseFirestore.instance.collection('vehicleBrand');

  Future<QuerySnapshot<Object?>> getVehicleBrand() async {
    return await collectionVehicleBrand.get();
  }

  Future<QuerySnapshot<Object?>> getModels(String id)  async {
    return  collectionVehicleBrand.doc(id).collection("models").get();
  }

  Future<void> getData() async {
    List<Vehicle?> vehicleBrand = [];
   QuerySnapshot<Object?>   snapshot =await getVehicleBrand();
   for(var item in snapshot.docs){
     vehicleBrand.add(
         Vehicle.fromJson(item.id));
   }
    for (var item in vehicleBrand) {
      QuerySnapshot? models = await getModels(item!.name);
      for (var element in models.docs) {
        vehicleBrand[vehicleBrand.indexOf(item)]?.models.add(
            VehicleModels.fromJson(
                element.data() as Map<String, dynamic>, element.id));
      }
    }
    _defaultDataManager?.setVehicleBrand(vehicleBrand);
    // return vehicleBrand;

  }
}
