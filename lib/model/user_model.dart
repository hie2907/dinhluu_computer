import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String fullName;
  final String emailAdress;
  final String password;
  final String userID;
  UserModel({
    required this.fullName,
    required this.emailAdress,
    required this.password,
    required this.userID,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      fullName: doc['fullName'],
      emailAdress: doc['emailAddress'],
      password: doc['password'],
      userID: doc['userUid'],
    );
  }
}
