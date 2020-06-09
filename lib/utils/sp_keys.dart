import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Keys{
  static final storage = FlutterSecureStorage();
  static final String fName = 'firstName';
  static final String customerID = 'customer_id';
  static final  String addressID = 'address_id';
  static final  String emailID = 'email_id';
  static final  String lastName = 'lastName';
  static final  String phoneNumber = 'phone';
  static final String pass = 'password';

  static clearAll() async {
    await storage.deleteAll();
  }
}