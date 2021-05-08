import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('UserData');
  Future updateUserData(
      String firstName, String lastName, String phone, String email) async {
    return await brewCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
    });
  }
}
