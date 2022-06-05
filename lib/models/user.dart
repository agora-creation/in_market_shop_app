import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String _id = '';
  String _email = '';
  String _password = '';
  String _name = '';
  String _zip = '';
  String _address = '';
  String _tel = '';
  String _shopId = '';
  List<String> itemIds = [];
  String _token = '';
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get email => _email;
  String get password => _password;
  String get name => _name;
  String get zip => _zip;
  String get address => _address;
  String get tel => _tel;
  String get shopId => _shopId;
  String get token => _token;
  DateTime get createdAt => _createdAt;

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _id = snapshot.data()!['id'] ?? '';
    _email = snapshot.data()!['email'] ?? '';
    _password = snapshot.data()!['password'] ?? '';
    _name = snapshot.data()!['name'] ?? '';
    _zip = snapshot.data()!['zip'] ?? '';
    _address = snapshot.data()!['address'] ?? '';
    _tel = snapshot.data()!['tel'] ?? '';
    _shopId = snapshot.data()!['shopId'] ?? '';
    itemIds = _convertList(snapshot.data()!['itemIds'] ?? []);
    _token = snapshot.data()!['token'] ?? '';
    _createdAt = snapshot.data()!['createdAt'].toDate() ?? DateTime.now();
  }

  List<String> _convertList(List list) {
    List<String> converted = [];
    for (String value in list) {
      converted.add(value);
    }
    return converted;
  }
}
