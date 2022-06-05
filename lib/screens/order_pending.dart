import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/models/shop_order.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/providers/order.dart';
import 'package:in_market_shop_app/widgets/order_list.dart';
import 'package:provider/provider.dart';

class OrderPendingScreen extends StatefulWidget {
  const OrderPendingScreen({Key? key}) : super(key: key);

  @override
  State<OrderPendingScreen> createState() => _OrderPendingScreenState();
}

class _OrderPendingScreenState extends State<OrderPendingScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    ShopModel? shop = authProvider.shop;
    final orderProvider = Provider.of<OrderProvider>(context);
    List<ShopOrderModel> orders = [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
              return OrderList(
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
