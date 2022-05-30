import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/functions.dart';
import 'package:in_market_shop_app/screens/item_add.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: 100,
        itemBuilder: (_, index) {
          return const Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black54,
              ),
            ),
            color: Colors.white,
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => nextScreen(context, const ItemAddScreen()),
        label: const Text('商品追加'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
    );
  }
}
