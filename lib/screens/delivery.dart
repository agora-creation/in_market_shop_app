import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_market_shop_app/models/delivery.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/providers/delivery.dart';
import 'package:in_market_shop_app/widgets/center_text.dart';
import 'package:in_market_shop_app/widgets/image_card.dart';
import 'package:provider/provider.dart';

class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    ShopModel? shop = authProvider.shop;
    final deliveryProvider = Provider.of<DeliveryProvider>(context);
    List<DeliveryModel> deliveryList = [];

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('配達者一覧'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: deliveryProvider.streamDeliveryList(shop: shop),
        builder: (context, snapshot) {
          deliveryList.clear();
          if (snapshot.hasData) {
            for (DocumentSnapshot<Map<String, dynamic>> doc
                in snapshot.data!.docs) {
              deliveryList.add(DeliveryModel.fromSnapshot(doc));
            }
          }
          if (deliveryList.isEmpty) {
            return const CenterText(label: '配達者がいません');
          }
          return GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: deliveryList.length,
            itemBuilder: (_, index) {
              DeliveryModel delivery = deliveryList[index];
              return ImageCard(
                image: delivery.imageUrl,
                title: delivery.name,
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
