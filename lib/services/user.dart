import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:in_market_shop_app/models/user.dart';

class UserService {
  final String _collection = 'user';
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void create(Map<String, dynamic> values) {
    _firebaseFirestore.collection(_collection).doc(values['id']).set(values);
  }

  void update(Map<String, dynamic> values) {
    _firebaseFirestore.collection(_collection).doc(values['id']).update(values);
  }

  void delete(Map<String, dynamic> values) {
    _firebaseFirestore.collection(_collection).doc(values['id']).delete();
  }

  Future<List<UserModel>> selectList({String? shopId}) async {
    List<UserModel> users = [];
    await _firebaseFirestore
        .collection(_collection)
        .where('shopId', isEqualTo: shopId ?? 'error')
        .orderBy('createdAt', descending: true)
        .get()
        .then((value) {
      for (DocumentSnapshot<Map<String, dynamic>> data in value.docs) {
        users.add(UserModel.fromSnapshot(data));
      }
    });
    return users;
  }
}
