import 'package:flutter/material.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/widgets/custom_checkbox.dart';
import 'package:in_market_shop_app/widgets/error_dialog.dart';
import 'package:in_market_shop_app/widgets/round_button.dart';
import 'package:provider/provider.dart';

class SettingShopScreen extends StatefulWidget {
  const SettingShopScreen({Key? key}) : super(key: key);

  @override
  State<SettingShopScreen> createState() => _SettingShopScreenState();
}

class _SettingShopScreenState extends State<SettingShopScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('店舗設定'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          CustomCheckbox(
            labelText: '注文者の画面に、商品の販売価格を表示させる',
            value: authProvider.priceViewController,
            onChanged: (value) => authProvider.priceViewChange(value),
          ),
          const SizedBox(height: 24),
          RoundButton(
            labelText: '変更内容を保存',
            labelColor: Colors.white,
            backgroundColor: Colors.blue.shade400,
            onPressed: () async {
              String? errorText = await authProvider.updateShop();
              if (errorText != null) {
                showDialog(
                  context: context,
                  builder: (_) => ErrorDialog(
                    message: errorText,
                  ),
                );
                return;
              }
              await authProvider.reloadShop();
              authProvider.clearController();
              if (!mounted) return;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
