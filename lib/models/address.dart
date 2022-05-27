class AddressModel {
  String _id = '';
  String _name = '';
  String _zip = '';
  String _address = '';
  String _tel = '';

  String get id => _id;
  String get name => _name;
  String get zip => _zip;
  String get address => _address;
  String get tel => _tel;

  AddressModel.fromMap(Map data) {
    _id = data['id'] ?? '';
    _name = data['name'] ?? '';
    _zip = data['zip'] ?? '';
    _address = data['address'] ?? '';
    _tel = data['tel'] ?? '';
  }

  Map toMap() => {
        'id': _id,
        'name': _name,
        'zip': _zip,
        'address': _address,
        'tel': _tel,
      };
}
