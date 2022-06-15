import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/functions.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/models/user.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/providers/user.dart';
import 'package:in_market_shop_app/screens/order_add_item.dart';
import 'package:in_market_shop_app/widgets/center_text.dart';
import 'package:in_market_shop_app/widgets/image_card.dart';
import 'package:provider/provider.dart';

class OrderAddScreen extends StatefulWidget {
  const OrderAddScreen({Key? key}) : super(key: key);

  @override
  State<OrderAddScreen> createState() => _OrderAddScreenState();
}

class _OrderAddScreenState extends State<OrderAddScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    ShopModel? shop = authProvider.shop;
    final userProvider = Provider.of<UserProvider>(context);
    List<UserModel> users = [];

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('注文する - 注文者選択'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: userProvider.streamUsers(shop: shop),
        builder: (context, snapshot) {
          users.clear();
          if (snapshot.hasData) {
            for (DocumentSnapshot<Map<String, dynamic>> doc
                in snapshot.data!.docs) {
              users.add(UserModel.fromSnapshot(doc));
            }
          }
          if (users.isEmpty) {
            return const CenterText(label: '注文者がいません');
          }
          return GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: users.length,
            itemBuilder: (_, index) {
              UserModel user = users[index];
              return ImageCard(
                image: user.imageUrl,
                title: user.name,
                onTap: () => nextScreen(
                  context,
                  OrderAddItemScreen(user: user),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
