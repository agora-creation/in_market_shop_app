import 'package:flutter/material.dart';
import 'package:in_market_shop_app/models/cart.dart';

class QuantityLgButton extends StatelessWidget {
  final CartModel cart;

  const QuantityLgButton({
    required this.cart,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade400),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.remove,
              color: Colors.blue.shade400,
              size: 24,
            ),
          ),
          Text(
            '納品数量:　${cart.quantity} ${cart.unit}',
            style: TextStyle(
              color: Colors.blue.shade400,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'SourceHanSans-Bold',
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              color: Colors.blue.shade400,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
