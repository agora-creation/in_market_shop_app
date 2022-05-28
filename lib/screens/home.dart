import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/functions.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/screens/setting.dart';
import 'package:in_market_shop_app/widgets/dashboard.dart';
import 'package:in_market_shop_app/widgets/dashboard_card.dart';
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
      body: Dashboard(
        children: [
          DashboardCard(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            iconData: Icons.shopping_cart,
            labelText: '受注待ち',
            chipText: '10',
            onTap: () => overlayScreen(context, const SettingScreen()),
          ),
          DashboardCard(
            iconData: Icons.local_shipping,
            labelText: '配達待ち',
            chipText: '2',
            onTap: () => overlayScreen(context, const SettingScreen()),
          ),
          DashboardCard(
            iconData: Icons.history_edu,
            labelText: '受注履歴',
            onTap: () => overlayScreen(context, const SettingScreen()),
          ),
          DashboardCard(
            iconData: Icons.add_shopping_cart,
            labelText: '新規注文',
            onTap: () => overlayScreen(context, const SettingScreen()),
          ),
          DashboardCard(
            iconData: Icons.bar_chart,
            labelText: '集計',
            onTap: () => overlayScreen(context, const SettingScreen()),
          ),
          DashboardCard(
            iconData: Icons.group,
            labelText: '注文者',
            onTap: () => overlayScreen(context, const SettingScreen()),
          ),
          DashboardCard(
            iconData: Icons.delivery_dining,
            labelText: '配達者',
            onTap: () => overlayScreen(context, const SettingScreen()),
          ),
          DashboardCard(
            iconData: Icons.inventory,
            labelText: '商品',
            onTap: () => overlayScreen(context, const SettingScreen()),
          ),
        ],
      ),
    );
  }
}
