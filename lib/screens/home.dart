import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/functions.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/screens/delivery.dart';
import 'package:in_market_shop_app/screens/item.dart';
import 'package:in_market_shop_app/screens/order_add.dart';
import 'package:in_market_shop_app/screens/order_history.dart';
import 'package:in_market_shop_app/screens/order_pending.dart';
import 'package:in_market_shop_app/screens/order_shipping.dart';
import 'package:in_market_shop_app/screens/setting.dart';
import 'package:in_market_shop_app/screens/total.dart';
import 'package:in_market_shop_app/screens/user.dart';
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
            onTap: () => overlayScreen(context, const OrderPendingScreen()),
          ),
          DashboardCard(
            iconData: Icons.local_shipping,
            labelText: '配達待ち',
            onTap: () => overlayScreen(context, const OrderShippingScreen()),
          ),
          DashboardCard(
            iconData: Icons.history_edu,
            labelText: '受注履歴',
            onTap: () => overlayScreen(context, const OrderHistoryScreen()),
          ),
          DashboardCard(
            iconData: Icons.add_shopping_cart,
            labelText: '注文する',
            onTap: () => overlayScreen(context, const OrderAddScreen()),
          ),
          DashboardCard(
            iconData: Icons.bar_chart,
            labelText: '集計',
            onTap: () => overlayScreen(context, const TotalScreen()),
          ),
          DashboardCard(
            iconData: Icons.group,
            labelText: '注文者一覧',
            onTap: () => overlayScreen(context, const UserScreen()),
          ),
          DashboardCard(
            iconData: Icons.delivery_dining,
            labelText: '配達者一覧',
            onTap: () => overlayScreen(context, const DeliveryScreen()),
          ),
          DashboardCard(
            iconData: Icons.inventory,
            labelText: '商品一覧',
            onTap: () => overlayScreen(context, const ItemScreen()),
          ),
        ],
      ),
    );
  }
}
