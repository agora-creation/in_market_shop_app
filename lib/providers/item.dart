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
  bool openController = false;

  void clearController() {
    numberController.text = '';
    nameController.text = '';
    priceController.text = '';
    unitController.text = '';
    descriptionController.text = '';
    openController = false;
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
      itemService.create({
        'id': id,
        'shopId': shop?.id,
        'number': numberController.text.trim(),
        'name': nameController.text.trim(),
        'price': int.parse(priceController.text.trim()),
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
      itemService.update({
        'id': item?.id,
        'number': numberController.text.trim(),
        'name': nameController.text.trim(),
        'price': int.parse(priceController.text.trim()),
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
}
