import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/style.dart';
import 'package:in_market_shop_app/models/shop_order.dart';

class OrderList extends StatelessWidget {
  final ShopOrderModel order;
  final Function()? onTap;

  const OrderList({
    required this.order,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: kBottomBorder,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.userName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSans-Bold',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: order.cartList.map((cart) {
                      return Text(
                        '${cart.name} ×${cart.quantity}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
