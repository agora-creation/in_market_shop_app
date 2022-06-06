import 'package:flutter/material.dart';
import 'package:in_market_shop_app/models/cart.dart';
import 'package:in_market_shop_app/widgets/quantity_lg_button.dart';

class CartList extends StatelessWidget {
  final CartModel cart;
  final int befQuantity;
  final Function()? removeOnTap;
  final Function()? addOnTap;

  const CartList({
    required this.cart,
    required this.befQuantity,
    this.removeOnTap,
    this.addOnTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cart.name,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSans-Bold',
                    ),
                  ),
                  Text(
                    '希望数量:　$befQuantity ${cart.unit}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              QuantityLgButton(
                cart: cart,
                removeOnTap: removeOnTap,
                addOnTap: addOnTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
