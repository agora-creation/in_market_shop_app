import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/functions.dart';
import 'package:in_market_shop_app/helpers/style.dart';
import 'package:in_market_shop_app/models/shop_order.dart';
import 'package:in_market_shop_app/providers/order.dart';
import 'package:in_market_shop_app/widgets/round_lg_button.dart';
import 'package:provider/provider.dart';

class Order1DetailScreen extends StatefulWidget {
  final ShopOrderModel order;

  const Order1DetailScreen({required this.order, Key? key}) : super(key: key);

  @override
  State<Order1DetailScreen> createState() => _Order1DetailScreenState();
}

class _Order1DetailScreenState extends State<Order1DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('受注待ち詳細'),
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
                  padding: const EdgeInsets.all(24),
                  children: [
                    const Text(
                      '注文情報',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SourceHanSans-Bold',
                      ),
                    ),
                    Text(
                      '注文元: ${widget.order.shopName}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      '注文日時: ${dateText('yyyy/MM/dd HH:mm', widget.order.createdAt)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Divider(height: 32),
                    const Text(
                      '注文商品',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SourceHanSans-Bold',
                      ),
                    ),
                    Column(
                      children: widget.order.cartList.map((cart) {
                        return Container(
                          decoration: kBottomBorder,
                          height: 100,
                          padding: const EdgeInsets.all(0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        'https://placehold.jp/300x200.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 18,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      cart.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SourceHanSans-Bold',
                                      ),
                                    ),
                                    Text(
                                      '数量:　${cart.quantity} ${cart.unit}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SourceHanSans-Bold',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                    RoundLgButton(
                      labelText: '配達待ちにする',
                      labelColor: Colors.white,
                      backgroundColor: Colors.orange.shade400,
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 8),
                    RoundLgButton(
                      labelText: '配達完了にする',
                      labelColor: Colors.white,
                      backgroundColor: Colors.blue.shade400,
                      onPressed: () async {
                        Navigator.pop(context);
                      },
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
