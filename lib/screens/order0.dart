import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/functions.dart';
import 'package:in_market_shop_app/helpers/style.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/models/shop_order.dart';
import 'package:in_market_shop_app/models/user.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/providers/order.dart';
import 'package:in_market_shop_app/screens/order0_detail.dart';
import 'package:in_market_shop_app/widgets/not_list_message.dart';
import 'package:in_market_shop_app/widgets/order_card.dart';
import 'package:in_market_shop_app/widgets/search_button.dart';
import 'package:provider/provider.dart';

class Order0Screen extends StatefulWidget {
  const Order0Screen({Key? key}) : super(key: key);

  @override
  State<Order0Screen> createState() => _Order0ScreenState();
}

class _Order0ScreenState extends State<Order0Screen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    ShopModel? shop = authProvider.shop;
    final orderProvider = Provider.of<OrderProvider>(context);
    List<ShopOrderModel> orders = [];

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('受注履歴'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                SearchButton(
                  iconData: Icons.calendar_month,
                  labelText: dateText('yyyy年MM月', orderProvider.month),
                  onPressed: () async {
                    DateTime? selected = await customMonthPicker(
                      context: context,
                      initialDate: orderProvider.month,
                    );
                    if (selected == null) return;
                    orderProvider.changeMonth(selected);
                  },
                ),
                const SizedBox(width: 8),
                SearchButton(
                  iconData: Icons.person,
                  labelText: orderProvider.user != null
                      ? orderProvider.user?.name ?? ''
                      : '指定なし',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => SearchUserDialog(
                        authProvider: authProvider,
                        orderProvider: orderProvider,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: orderProvider.streamOrders(shop: shop, status: 0),
              builder: (context, snapshot) {
                orders.clear();
                if (snapshot.hasData) {
                  for (DocumentSnapshot<Map<String, dynamic>> doc
                      in snapshot.data!.docs) {
                    orders.add(ShopOrderModel.fromSnapshot(doc));
                  }
                }
                if (orders.isEmpty) {
                  return const NotListMessage(message: '配達完了の注文がありません');
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: orders.length,
                  itemBuilder: (_, index) {
                    ShopOrderModel order = orders[index];
                    return OrderCard(
                      order: order,
                      onTap: () => nextScreen(
                        context,
                        Order0DetailScreen(order: order),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchUserDialog extends StatefulWidget {
  final AuthProvider authProvider;
  final OrderProvider orderProvider;

  const SearchUserDialog({
    required this.authProvider,
    required this.orderProvider,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchUserDialog> createState() => _SearchUserDialogState();
}

class _SearchUserDialogState extends State<SearchUserDialog> {
  List<UserModel> users = [];

  void _init() async {
    ShopModel? shop = widget.authProvider.shop;
    List<UserModel> tmp = await widget.authProvider.selectUsers(shop?.id);
    if (mounted) {
      setState(() => users = tmp);
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        '注文者で検索',
        style: TextStyle(fontSize: 16),
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: 250,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: users.length,
          itemBuilder: (_, index) {
            UserModel user = users[index];
            return Container(
              decoration: kBottomBorder,
              child: RadioListTile(
                title: Text(
                  user.name,
                  style: const TextStyle(fontSize: 18),
                ),
                value: user,
                groupValue: widget.orderProvider.user,
                onChanged: (value) {},
              ),
            );
          },
        ),
      ),
    );
  }
}
