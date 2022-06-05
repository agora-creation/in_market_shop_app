import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_market_shop_app/models/shop.dart';

class OrderProvider with ChangeNotifier {
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
