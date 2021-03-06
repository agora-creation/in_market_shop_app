import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/functions.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/models/shop_order.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/providers/order.dart';
import 'package:in_market_shop_app/screens/delivery.dart';
import 'package:in_market_shop_app/screens/item.dart';
import 'package:in_market_shop_app/screens/order0.dart';
import 'package:in_market_shop_app/screens/order1.dart';
import 'package:in_market_shop_app/screens/order2.dart';
import 'package:in_market_shop_app/screens/order_add.dart';
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
    final orderProvider = Provider.of<OrderProvider>(context);

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
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: orderProvider.streamOrders(shop: shop, status: 1),
            builder: (context, snapshot) {
              List<ShopOrderModel> orders = [];
              if (snapshot.hasData) {
                for (DocumentSnapshot<Map<String, dynamic>> doc
                    in snapshot.data!.docs) {
                  orders.add(ShopOrderModel.fromSnapshot(doc));
                }
              }
              return DashboardCard(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2,
                iconData: Icons.shopping_cart,
                labelText: '????????????',
                count: orders.length,
                onTap: () => overlayScreen(context, const Order1Screen()),
              );
            },
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: orderProvider.streamOrders(shop: shop, status: 2),
            builder: (context, snapshot) {
              List<ShopOrderModel> orders = [];
              if (snapshot.hasData) {
                for (DocumentSnapshot<Map<String, dynamic>> doc
                    in snapshot.data!.docs) {
                  orders.add(ShopOrderModel.fromSnapshot(doc));
                }
              }
              return DashboardCard(
                iconData: Icons.local_shipping,
                labelText: '????????????',
                count: orders.length,
                onTap: () => overlayScreen(context, const Order2Screen()),
              );
            },
          ),
          DashboardCard(
            iconData: Icons.history_edu,
            labelText: '????????????',
            onTap: () => overlayScreen(context, const Order0Screen()),
          ),
          DashboardCard(
            iconData: Icons.add_shopping_cart,
            labelText: '????????????',
            onTap: () => overlayScreen(context, const OrderAddScreen()),
          ),
          DashboardCard(
            crossAxisCellCount: 3,
            iconData: Icons.bar_chart,
            labelText: '??????',
            onTap: () => overlayScreen(context, const TotalScreen()),
          ),
          DashboardCard(
            iconData: Icons.group,
            labelText: '???????????????',
            onTap: () => overlayScreen(context, const UserScreen()),
          ),
          DashboardCard(
            iconData: Icons.delivery_dining,
            labelText: '???????????????',
            onTap: () => overlayScreen(context, const DeliveryScreen()),
          ),
          DashboardCard(
            iconData: Icons.inventory,
            labelText: '????????????',
            onTap: () => overlayScreen(context, const ItemScreen()),
          ),
        ],
      ),
    );
  }
}
