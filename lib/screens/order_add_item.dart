import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/models/shop_item.dart';
import 'package:in_market_shop_app/models/user.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/providers/item.dart';
import 'package:in_market_shop_app/widgets/center_text.dart';
import 'package:in_market_shop_app/widgets/image_card.dart';
import 'package:provider/provider.dart';

class OrderAddItemScreen extends StatefulWidget {
  final UserModel user;

  const OrderAddItemScreen({required this.user, Key? key}) : super(key: key);

  @override
  State<OrderAddItemScreen> createState() => _OrderAddItemScreenState();
}

class _OrderAddItemScreenState extends State<OrderAddItemScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    ShopModel? shop = authProvider.shop;
    final itemProvider = Provider.of<ItemProvider>(context);
    List<ShopItemModel> items = [];

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('注文する - ${widget.user.name} - 注文商品選択'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: itemProvider.streamItems(shop: shop),
        builder: (context, snapshot) {
          items.clear();
          if (snapshot.hasData) {
            for (DocumentSnapshot<Map<String, dynamic>> doc
                in snapshot.data!.docs) {
              items.add(ShopItemModel.fromSnapshot(doc));
            }
          }
          if (items.isEmpty) {
            return const CenterText(label: '注文する商品がありません');
          }
          return GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: items.length,
            itemBuilder: (_, index) {
              ShopItemModel item = items[index];
              return ImageCard(
                title: item.name,
                subTitle: shop?.priceView == true ? '¥ ${item.price}' : null,
                onTap: () {},
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
          Navigator.of(context, rootNavigator: true).pop();
        },
        label: const Text('注文して配達完了にする'),
        icon: const Icon(Icons.check),
        backgroundColor: Colors.blue,
        elevation: 3,
      ),
    );
  }
}
