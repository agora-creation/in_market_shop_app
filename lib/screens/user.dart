import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/models/user.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/providers/user.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
        title: const Text('注文者一覧'),
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
          if (users.isEmpty) return const Center(child: Text('注文者はいません'));
          return GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: users.length,
            itemBuilder: (_, index) {
              UserModel user = users[index];
              return GestureDetector(
                onTap: () {},
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(user.name),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
