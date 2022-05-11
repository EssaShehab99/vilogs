import 'package:easy_localization/easy_localization.dart';

class Validate{
  validator(value){
    if (value == null || value.isEmpty) {
      return 'validate-value';
    }
    return null;
  }
  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}