import 'package:flutter/cupertino.dart';
import 'package:vilogs/data/models/history.dart';

import '../models/enginner.dart';
import '../models/user.dart';

class EngineerManager extends ChangeNotifier {
  List<Engineer> engineerList = [
    Engineer(id: "1",name: "Magdi",availability: true,rate: 5,isCurrent: true),
    Engineer(id: "2",name: "Ahmed",availability: false,rate: 4,isCurrent: false),
    Engineer(id: "3",name: "Hamza",availability: true,rate: 2,isCurrent: false),
    Engineer(id: "4",name: "Ali",availability: true,rate: 3,isCurrent: false),
    Engineer(id: "5",name: "Mohammed",availability: false,rate: 5,isCurrent: false),
  ];
  
  void deleteEngineer(String id){
    engineerList.remove(engineerList.firstWhere((element) => element.id==id));
    notifyListeners();
  }

  List<Engineer> getCurrent(){
    return engineerList.where((element) => element.isCurrent).toList();
  }
  List<Engineer> getAvailableEngineer(){
    return engineerList.where((element) => !element.isCurrent).toList();
  }
}
