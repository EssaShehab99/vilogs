import 'package:flutter/cupertino.dart';
import '/data/models/issues.dart';


class IssuesManager extends ChangeNotifier {
  List<Issues> issuesList = [
    Issues(key: "Date Of Accurint",value: "2021/11/22",isInProgress: true),
    Issues(key: "Description",value: "Car Temperature is very high",isInProgress: true),
    Issues(key: "Sign/led",value: "Open",isInProgress: true),
    Issues(key: "Date Of Accurint",value: "2021/11/22",isInProgress: false),
    Issues(key: "Description",value: "Car Temperature is very high",isInProgress: false),
    Issues(key: "Sign/led",value: "Open",isInProgress: false),
  ];
  List<Issues> getPast(){
    return issuesList.where((element) => !element.isInProgress).toList();
  }
  List<Issues> getIsInProgress(){
    return issuesList.where((element) => element.isInProgress).toList();
  }
}
