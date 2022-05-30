import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/models/shop_item.dart';
import 'package:in_market_shop_app/services/shop_item.dart';

class ItemProvider with ChangeNotifier {
  ShopItemService itemService = ShopItemService();

  File? imageFile;
  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool openController = false;

  void clearController() {
    numberController.text = '';
    nameController.text = '';
    priceController.text = '';
    unitController.text = '';
    descriptionController.text = '';
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

  Future pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(source: ImageSource.gallery);
    imageFile = File(file!.path);
  }

  void openChange(bool value) {
    openController = value;
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
      itemService.create({
        'id': id,
        'shopId': shop?.id,
        'number': numberController.text.trim(),
        'name': nameController.text.trim(),
        'price': price,
        'unit': unitController.text.trim(),
        'imageUrl': '',
        'description': descriptionController.text,
        'open': openController,
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      errorText = '商品の追加に失敗しました。';
    }
    return errorText;
  }

  Future<String?> update({ShopItemModel? item}) async {
    String? errorText;
    if (item == null) errorText = '商品情報の更新に失敗しました。';
    if (numberController.text.isEmpty) errorText = '商品番号を入力してください。';
    if (nameController.text.isEmpty) errorText = '商品名を入力してください。';
    try {
      int price = 0;
      if (priceController.text.isNotEmpty) {
        price = int.parse(priceController.text.trim());
      }
      itemService.update({
        'id': item?.id,
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

  Future<String?> delete({ShopItemModel? item}) async {
    String? errorText;
    if (item == null) errorText = '商品の削除に失敗しました。';
    try {
      itemService.delete({
        'id': item?.id,
        'shopId': item?.shopId,
      });
    } catch (e) {
      errorText = '商品の削除に失敗しました。';
    }
    return errorText;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? streamList({ShopModel? shop}) {
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
