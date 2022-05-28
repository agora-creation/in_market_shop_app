import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:in_market_shop_app/models/shop.dart';

class ShopService {
  final String _collection = 'shop';
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

  Future<ShopModel?> select({String? id}) async {
    ShopModel? shop;
    await _firebaseFirestore
        .collection(_collection)
        .doc(id)
        .get()
        .then((value) {
      shop = ShopModel.fromSnapshot(value);
    });
    return shop;
  }
}
