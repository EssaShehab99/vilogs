class Vehicle{
  String name;
  List<VehicleModels> models;
  Vehicle({required this.name,required this.models});

  factory Vehicle.fromJson(String id) => Vehicle(
    name: id, models: [],
);


}
class VehicleModels{
  String name;
  List<String> years;
  VehicleModels({required this.name,required this.years,});

  factory VehicleModels.fromJson(Map<String, dynamic> json,String id) => VehicleModels(
    name: id,
    years: List<String>.from(json["years"]??[]),
  );
}