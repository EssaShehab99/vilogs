import 'package:flutter/cupertino.dart';
import 'package:vilogs/data/models/default_data.dart';

import '../models/user.dart';

class DefaultDataManager extends ChangeNotifier {
  List<Vehicle?> vehicleBrandList = [];
 //  List<String> vehicleList=[];
 //  List<String> modelsList=[];
 //  List<String>? yearsList;
 //  setVehicleList() {
 //    for(var item in vehicleBrandList){
 //      vehicleList.add(item!.name);
 //    }
 //    notifyListeners();
 //  }
 //
 //
 // Future<void> setModelsList(String value) async{
 //    modelsList=[];
 //    Vehicle? items=vehicleBrandList.firstWhere((element) => element?.name==value);
 //    if(items!=null)
 //    for(VehicleModels item in items.models)
 //      modelsList.add(item.name);
 //    notifyListeners();
 //  }

  Vehicle? currentVehicleBrand;
  VehicleModels? currentModel;
  void setCurrentVehicleBrand(String value){
    currentModel=null;
    currentVehicleBrand= vehicleBrandList.firstWhere((element) => element?.name==value);
    notifyListeners();
  }
  void setCurrentModel(String value){
    currentModel= currentVehicleBrand?.models.firstWhere((element) => element.name==value);
    notifyListeners();
  }

  List<String> vehicleList(){
    return List<String>.generate(
        this.vehicleBrandList.length, (index) => this.vehicleBrandList[index]!.name);
  }
  List<String> modelsList(){
    if(currentVehicleBrand==null)
      return [];
    return List<String>.generate(
        this.currentVehicleBrand!.models.length, (index) => this.currentVehicleBrand!.models[index].name);
  }
  List<String> yearsList(){
    if(currentModel==null)
    return [];
    return List<String>.generate(
        this.currentModel!.years.length, (index) => this.currentModel!.years[index]);
  }

  void setVehicleBrand(List<Vehicle?> vehicleBrandList) {
    this.vehicleBrandList = vehicleBrandList;
    notifyListeners();
  }
}
