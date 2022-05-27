import 'package:cloud_firestore/cloud_firestore.dart';

class ShopItem {
  String _id = '';
  String _shopId = '';
  String _number = '';
  String _name = '';
  int _price = 0;
  String _unit = '';
  String _imageUrl = '';
  String _description = '';
  bool _open = false;
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get shopId => _shopId;
  String get number => _number;
  String get name => _name;
  int get price => _price;
  String get unit => _unit;
  String get imageUrl => _imageUrl;
  String get description => _description;
  bool get open => _open;
  DateTime get createdAt => _createdAt;

  ShopItem.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _id = snapshot.data()!['id'] ?? '';

    _createdAt = snapshot.data()!['createdAt'].toDate() ?? DateTime.now();
  }
}
