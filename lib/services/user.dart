import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final String _collection = 'user';
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void update(Map<String, dynamic> values) {
    _firebaseFirestore.collection(_collection).doc(values['id']).update(values);
  }
}
