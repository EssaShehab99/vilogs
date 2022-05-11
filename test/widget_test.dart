import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

import 'Validate.dart';

void main() {

  group('signUp', () {
    test('value should be incremented', () {
      Validate validate = Validate();

      expect(validate.validator("text"), null);
      expect(validate.validator(""), 'validate-value');
      expect(validate.validateStructure(""), false);
      expect(validate.validateStructure("a"), false);
      expect(validate.validateStructure("tEst@123456"), true);
    });
    });


}




