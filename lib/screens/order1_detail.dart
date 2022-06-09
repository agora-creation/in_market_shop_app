import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/functions.dart';
import 'package:in_market_shop_app/models/cart.dart';
import 'package:in_market_shop_app/models/shop_order.dart';
import 'package:in_market_shop_app/providers/order.dart';
import 'package:in_market_shop_app/widgets/cart_list.dart';
import 'package:in_market_shop_app/widgets/error_dialog.dart';
import 'package:in_market_shop_app/widgets/label_column.dart';
import 'package:in_market_shop_app/widgets/round_button.dart';
import 'package:provider/provider.dart';

class Order1DetailScreen extends StatefulWidget {
  final ShopOrderModel order;

  const Order1DetailScreen({required this.order, Key? key}) : super(key: key);

  @override
  State<Order1DetailScreen> createState() => _Order1DetailScreenState();
}

class _Order1DetailScreenState extends State<Order1DetailScreen> {
  List<CartModel> cartList = [];

  void _init() {
    if (mounted) {
      setState(() => cartList = widget.order.cartList);
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('受注待ち - 詳細'),
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
                      children: cartList.map((cart) {
                        return CartList(
                          cart: cart,
                          removeOnTap: () {
                            if (cart.quantity > 1) {
                              setState(() => cart.quantity -= 1);
                            }
                          },
                          addOnTap: () {
                            setState(() => cart.quantity += 1);
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundButton(
                          labelText: 'キャンセルする',
                          labelColor: Colors.white,
                          backgroundColor: Colors.red.shade400,
                          onPressed: () async {
                            String? errorText = await orderProvider.cancel(
                              order: widget.order,
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
                        RoundButton(
                          labelText: '配達待ちにする',
                          labelColor: Colors.white,
                          backgroundColor: Colors.blue.shade400,
                          onPressed: () async {
                            String? errorText = await orderProvider.update(
                              order: widget.order,
                              cartList: cartList,
                              status: 2,
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
