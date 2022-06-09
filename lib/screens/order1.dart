import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/functions.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/models/shop_order.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/providers/order.dart';
import 'package:in_market_shop_app/screens/order1_detail.dart';
import 'package:in_market_shop_app/widgets/center_text.dart';
import 'package:in_market_shop_app/widgets/order_card.dart';
import 'package:provider/provider.dart';

class Order1Screen extends StatefulWidget {
  const Order1Screen({Key? key}) : super(key: key);

  @override
  State<Order1Screen> createState() => _Order1ScreenState();
}

class _Order1ScreenState extends State<Order1Screen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    ShopModel? shop = authProvider.shop;
    final orderProvider = Provider.of<OrderProvider>(context);
    List<ShopOrderModel> orders = [];

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('受注待ち'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: orderProvider.streamOrders(shop: shop, status: 1),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (DocumentSnapshot<Map<String, dynamic>> doc
                in snapshot.data!.docs) {
              orders.add(ShopOrderModel.fromSnapshot(doc));
            }
          }
          if (orders.isEmpty) {
            return const CenterText(label: '受注待ちの注文がありません');
          }
          return ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: orders.length,
            itemBuilder: (_, index) {
              ShopOrderModel order = orders[index];
              return OrderCard(
                order: order,
                onTap: () => nextScreen(
                  context,
                  Order1DetailScreen(order: order),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
