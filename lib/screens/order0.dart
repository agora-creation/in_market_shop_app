import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/models/shop_order.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/providers/order.dart';
import 'package:in_market_shop_app/widgets/order_card.dart';
import 'package:provider/provider.dart';

class Order0Screen extends StatefulWidget {
  const Order0Screen({Key? key}) : super(key: key);

  @override
  State<Order0Screen> createState() => _Order0ScreenState();
}

class _Order0ScreenState extends State<Order0Screen> {
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
        title: const Text('受注履歴'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: orderProvider.streamOrders(shop: shop, status: 0),
        builder: (context, snapshot) {
          orders.clear();
          if (snapshot.hasData) {
            for (DocumentSnapshot<Map<String, dynamic>> doc
                in snapshot.data!.docs) {
              orders.add(ShopOrderModel.fromSnapshot(doc));
            }
          }
          if (orders.isEmpty) return const Center(child: Text('注文がありません'));
          return ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: orders.length,
            itemBuilder: (_, index) {
              ShopOrderModel order = orders[index];
              return OrderCard(
                order: order,
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
