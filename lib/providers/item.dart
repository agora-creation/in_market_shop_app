import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/models/shop_item.dart';
import 'package:in_market_shop_app/services/shop_item.dart';

class ItemProvider with ChangeNotifier {
  ShopItemService itemService = ShopItemService();

  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Uint8List? imageFile;
  bool openController = false;

  void clearController() {
    numberController.text = '';
    nameController.text = '';
    priceController.text = '';
    unitController.text = '';
    descriptionController.text = '';
    imageFile = null;
    openController = false;
  }

  void setController(ShopItemModel item) {
    numberController.text = item.number;
    nameController.text = item.name;
    priceController.text = item.price.toString();
    unitController.text = item.unit;
    descriptionController.text = item.description;
    openController = item.open;
  }

  void openChange(bool value) {
    openController = value;
    notifyListeners();
  }

  Future imagePicker() async {
    FilePickerResult? result;
    result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;
    imageFile = result.files.single.bytes;
    notifyListeners();
  }

  Future<String?> create({ShopModel? shop}) async {
    String? errorText;
    if (shop == null) errorText = '商品の追加に失敗しました。';
    if (numberController.text.isEmpty) errorText = '商品番号を入力してください。';
    if (nameController.text.isEmpty) errorText = '商品名を入力してください。';
    try {
      String id = itemService.newId(shop?.id);
      int price = 0;
      if (priceController.text.isNotEmpty) {
        price = int.parse(priceController.text.trim());
      }
      Reference reference =
          FirebaseStorage.instance.ref().child('item').child(id);
      final UploadTask uploadTask = reference.putData(imageFile!);
      uploadTask.whenComplete(() async {
        String imageUrl = await uploadTask.snapshot.ref.getDownloadURL();
        itemService.create({
          'id': id,
          'shopId': shop?.id,
          'number': numberController.text.trim(),
          'name': nameController.text.trim(),
          'price': price,
          'unit': unitController.text.trim(),
          'imageUrl': imageUrl,
          'description': descriptionController.text,
          'open': openController,
          'createdAt': DateTime.now(),
        });
      });
    } catch (e) {
      errorText = '商品の追加に失敗しました。';
    }
    return errorText;
  }

  Future<String?> update({required ShopItemModel item}) async {
    String? errorText;
    if (numberController.text.isEmpty) errorText = '商品番号を入力してください。';
    if (nameController.text.isEmpty) errorText = '商品名を入力してください。';
    try {
      int price = 0;
      if (priceController.text.isNotEmpty) {
        price = int.parse(priceController.text.trim());
      }
      itemService.update({
        'id': item.id,
        'shopId': item.shopId,
        'number': numberController.text.trim(),
        'name': nameController.text.trim(),
        'price': price,
        'unit': unitController.text.trim(),
        'description': descriptionController.text,
        'open': openController,
      });
    } catch (e) {
      errorText = '商品情報の更新に失敗しました。';
    }
    return errorText;
  }

  Future<String?> delete({required ShopItemModel item}) async {
    String? errorText;
    try {
      itemService.delete({
        'id': item.id,
        'shopId': item.shopId,
      });
    } catch (e) {
      errorText = '商品の削除に失敗しました。';
    }
    return errorText;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? streamItems({ShopModel? shop}) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? ret;
    ret = FirebaseFirestore.instance
        .collection('shop')
        .doc(shop?.id ?? 'error')
        .collection('item')
        .orderBy('createdAt', descending: true)
        .snapshots();
    return ret;
  }
}
