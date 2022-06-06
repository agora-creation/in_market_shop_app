import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/functions.dart';
import 'package:in_market_shop_app/models/shop_order.dart';
import 'package:in_market_shop_app/providers/order.dart';
import 'package:in_market_shop_app/widgets/cart_list2.dart';
import 'package:in_market_shop_app/widgets/error_dialog.dart';
import 'package:in_market_shop_app/widgets/label_column.dart';
import 'package:in_market_shop_app/widgets/round_sm_button.dart';
import 'package:provider/provider.dart';

class Order2DetailScreen extends StatefulWidget {
  final ShopOrderModel order;

  const Order2DetailScreen({required this.order, Key? key}) : super(key: key);

  @override
  State<Order2DetailScreen> createState() => _Order2DetailScreenState();
}

class _Order2DetailScreenState extends State<Order2DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('配達待ち - 詳細'),
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
                      ],
                    ),
                    const SizedBox(height: 16),
                    LabelColumn(
                      labelText: '注文商品',
                      children: widget.order.cartList.map((cart) {
                        return CartList2(cart: cart);
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundSmButton(
                          labelText: '配達完了にする',
                          labelColor: Colors.white,
                          backgroundColor: Colors.blue.shade400,
                          onPressed: () async {
                            String? errorText = await orderProvider.update(
                              order: widget.order,
                              cartList: widget.order.cartList,
                              status: 0,
                            );
                            if (errorText != null) {
                              showDialog(
                                context: context,
                                builder: (_) => ErrorDialog(
                                  message: errorText,
                                ),
                              );
                              return;
                            }
                            if (!mounted) return;
                            Navigator.pop(context);
                          },
                        ),
                      ],
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
