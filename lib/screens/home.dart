import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:in_market_shop_app/helpers/functions.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/screens/setting.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    ShopModel? shop = authProvider.shop;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(shop?.name ?? ''),
        actions: [
          IconButton(
            onPressed: () => overlayScreen(context, const SettingScreen()),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: const [
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2,
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Text('受注待ち'),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Text('配達待ち'),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Text('受注履歴'),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Text('新規注文'),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Text('集計'),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Text('顧客'),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Text('配達者'),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Text('商品'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
