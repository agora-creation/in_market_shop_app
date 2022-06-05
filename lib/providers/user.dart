import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_market_shop_app/models/shop.dart';

class UserProvider with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? streamUsers({
    ShopModel? shop,
  }) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? ret;
    ret = FirebaseFirestore.instance
        .collection('user')
        .where('shopId', isEqualTo: shop?.id ?? 'error')
        .orderBy('createdAt', descending: true)
        .snapshots();
    return ret;
  }
}
