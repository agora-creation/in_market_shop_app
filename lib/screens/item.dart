import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/functions.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/models/shop_item.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/providers/item.dart';
import 'package:in_market_shop_app/screens/item_add.dart';
import 'package:in_market_shop_app/screens/item_detail.dart';
import 'package:in_market_shop_app/widgets/center_text.dart';
import 'package:in_market_shop_app/widgets/image_card.dart';
import 'package:provider/provider.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({Key? key}) : super(key: key);

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
        title: const Text('商品一覧'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
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
            return const CenterText(label: '商品を追加してください');
          }
          return GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: items.length,
            itemBuilder: (_, index) {
              ShopItemModel item = items[index];
              return ImageCard(
                image: item.imageUrl,
                title: item.name,
                subTitle: '¥ ${item.price} / ${item.unit}',
                onTap: () {
                  itemProvider.setController(item);
                  nextScreen(context, ItemDetailScreen(item: item));
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          itemProvider.clearController();
          nextScreen(context, const ItemAddScreen());
        },
        label: const Text('商品追加'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        elevation: 3,
      ),
    );
  }
}
