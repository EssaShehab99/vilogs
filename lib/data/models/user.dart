import 'package:cloud_firestore/cloud_firestore.dart';

enum TypeCharacter { individual, engineer }

class User {
  String? name;
  String? email;
  String? vehicleBrand;
  String? vehicleModel;
  String? password;
  DateTime? manufactureYear;
  TypeCharacter? typeCharacter;

  // DocumentReference? reference;

  User({
    this.name,
     this.email,
    this.vehicleBrand,
    this.manufactureYear,
    this.vehicleModel,
    this.typeCharacter,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json["name"],
      email: json["email"],
      manufactureYear: json["manufactureYear"] != null
          ? (json["manufactureYear"] as Timestamp).toDate()
          : DateTime.now(),
      vehicleModel: json["vehicleModel"],
      vehicleBrand: json["vehicleBrand"],
      typeCharacter: TypeCharacter.values
          .firstWhere((element) => element.name == json["typeCharacter"]));

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "name": name,
      "email": email,
      "manufactureYear": manufactureYear,
      "vehicleModel": vehicleModel,
      "vehicleBrand": vehicleBrand,
      "password": password,
      "typeCharacter": typeCharacter?.name
    };
  }

// factory User.fromSnapshot(DocumentSnapshot snapshot) {
//   final user =
//       User.fromJson(snapshot.data() as Map<String, dynamic>);
//   user.reference = snapshot.reference;
//   return user;
// }
}
