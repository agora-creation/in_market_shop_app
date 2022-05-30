import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/functions.dart';
import 'package:in_market_shop_app/helpers/style.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/models/shop_item.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/providers/item.dart';
import 'package:in_market_shop_app/screens/item_add.dart';
import 'package:in_market_shop_app/screens/item_detail.dart';
import 'package:in_market_shop_app/widgets/item_card.dart';
import 'package:in_market_shop_app/widgets/not_list_message.dart';
import 'package:provider/provider.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final itemProvider = Provider.of<ItemProvider>(context);
    ShopModel? shop = authProvider.shop;
    List<ShopItemModel> items = [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        stream: itemProvider.streamList(shop: shop),
        builder: (context, snapshot) {
          items.clear();
          if (snapshot.hasData) {
            for (DocumentSnapshot<Map<String, dynamic>> doc
                in snapshot.data!.docs) {
              items.add(ShopItemModel.fromSnapshot(doc));
            }
          }
          if (items.isEmpty) {
            return const NotListMessage(message: '商品を追加してください');
          }
          return GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            gridDelegate: itemGridDelegate,
            itemCount: items.length,
            itemBuilder: (_, index) {
              ShopItemModel item = items[index];
              return ItemCard(
                name: item.name,
                price: shop?.priceView == true ? '¥ ${item.price}' : null,
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
        elevation: 0,
      ),
    );
  }
}
