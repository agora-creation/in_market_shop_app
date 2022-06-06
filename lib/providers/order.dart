import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_market_shop_app/models/cart.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/models/shop_order.dart';
import 'package:in_market_shop_app/models/user.dart';
import 'package:in_market_shop_app/services/shop_order.dart';

class OrderProvider with ChangeNotifier {
  ShopOrderService orderService = ShopOrderService();

  Future<String?> create({
    ShopModel? shop,
    UserModel? user,
    List<CartModel>? cartList,
  }) async {
    String? errorText;
    if (shop == null) errorText = '注文に失敗しました。';
    if (user == null) errorText = '注文に失敗しました。';
    if (cartList == null) errorText = 'カートに商品がありません。';
    try {
      List<Map> newCartList = [];
      for (CartModel cart in cartList ?? []) {
        newCartList.add(cart.toMap());
      }
      String newId = orderService.newId(shop?.id);
      orderService.create({
        'id': newId,
        'shopId': shop?.id,
        'shopName': shop?.name,
        'userId': user?.id,
        'userName': user?.name,
        'cartList': newCartList,
        'deliveryId': '',
        'status': 0,
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      errorText = '注文に失敗しました。';
    }
    return errorText;
  }

  Future<String?> update({
    ShopOrderModel? order,
    List<CartModel>? cartList,
    required int status,
  }) async {
    String? errorText;
    if (order == null) errorText = '注文情報の更新に失敗しました。';
    if (cartList == null) errorText = 'カートに商品がありません。';
    try {
      orderService.update({
        'id': order?.id,
        'shopId': order?.shopId,
        'status': status,
      });
    } catch (e) {
      errorText = '注文情報の更新に失敗しました。';
    }
    return errorText;
  }

  Future<String?> cancel({ShopOrderModel? order}) async {
    String? errorText;
    if (order == null) errorText = '注文のキャンセルに失敗しました。';
    try {
      orderService.delete({
        'id': order?.id,
        'shopId': order?.shopId,
      });
    } catch (e) {
      errorText = '注文のキャンセルに失敗しました。';
    }
    return errorText;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? streamOrders({
    ShopModel? shop,
    int? status,
  }) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? ret;
    ret = FirebaseFirestore.instance
        .collection('shop')
        .doc(shop?.id ?? 'error')
        .collection('order')
        .where('status', isEqualTo: status)
        .orderBy('createdAt', descending: true)
        .snapshots();
    return ret;
  }
}
