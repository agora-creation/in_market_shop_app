import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/functions.dart';
import 'package:in_market_shop_app/models/shop_order.dart';
import 'package:in_market_shop_app/widgets/cart_list2.dart';
import 'package:in_market_shop_app/widgets/label_column.dart';

class Order0DetailScreen extends StatefulWidget {
  final ShopOrderModel order;

  const Order0DetailScreen({required this.order, Key? key}) : super(key: key);

  @override
  State<Order0DetailScreen> createState() => _Order0DetailScreenState();
}

class _Order0DetailScreenState extends State<Order0DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('受注履歴 - 詳細'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Card(
                elevation: 3,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    LabelColumn(
                      labelText: '注文情報',
                      children: [
                        Text(
                          '注文日時: ${dateText('yyyy/MM/dd HH:mm', widget.order.createdAt)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          '注文者: ${widget.order.userName}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          '配達者: ${widget.order.deliveryName}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    LabelColumn(
                      labelText: '注文商品',
                      children: widget.order.cartList.map((cart) {
                        return CartList2(cart: cart);
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
