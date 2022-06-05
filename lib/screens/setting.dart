import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/functions.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/screens/login.dart';
import 'package:in_market_shop_app/screens/setting_email.dart';
import 'package:in_market_shop_app/screens/setting_name.dart';
import 'package:in_market_shop_app/screens/setting_password.dart';
import 'package:in_market_shop_app/screens/setting_shop.dart';
import 'package:in_market_shop_app/widgets/round_lg_button.dart';
import 'package:in_market_shop_app/widgets/tap_list_tile.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    ShopModel? shop = authProvider.shop;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('各種設定'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TapListTile(
            title: '名前の変更',
            subtitle: shop?.name,
            onTap: () {
              authProvider.nameController.text = shop?.name ?? '';
              nextScreen(context, const SettingNameScreen());
            },
          ),
          TapListTile(
            title: 'メールアドレスの変更',
            subtitle: shop?.email,
            onTap: () {
              authProvider.emailController.text = shop?.email ?? '';
              nextScreen(context, const SettingEmailScreen());
            },
          ),
          TapListTile(
            title: 'パスワードの変更',
            onTap: () {
              nextScreen(context, const SettingPasswordScreen());
            },
          ),
          TapListTile(
            title: '店舗設定',
            onTap: () {
              nextScreen(context, const SettingShopScreen());
            },
          ),
          const SizedBox(height: 32),
          RoundLgButton(
            labelText: 'ログアウト',
            labelColor: Colors.blue.shade400,
            borderColor: Colors.blue.shade400,
            onPressed: () async {
              await authProvider.logout();
              if (!mounted) return;
              changeScreen(context, const LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}
