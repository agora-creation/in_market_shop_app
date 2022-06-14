import 'package:flutter/material.dart';
import 'package:in_market_shop_app/models/shop.dart';
import 'package:in_market_shop_app/providers/auth.dart';
import 'package:in_market_shop_app/providers/item.dart';
import 'package:in_market_shop_app/widgets/custom_text_button.dart';
import 'package:in_market_shop_app/widgets/custom_text_form_field2.dart';
import 'package:in_market_shop_app/widgets/error_dialog.dart';
import 'package:in_market_shop_app/widgets/round_button.dart';
import 'package:in_market_shop_app/widgets/switch_list.dart';
import 'package:provider/provider.dart';

class ItemAddScreen extends StatefulWidget {
  const ItemAddScreen({Key? key}) : super(key: key);

  @override
  State<ItemAddScreen> createState() => _ItemAddScreenState();
}

class _ItemAddScreenState extends State<ItemAddScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    ShopModel? shop = authProvider.shop;
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('商品追加'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Card(
                elevation: 3,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    itemProvider.imageFile != null
                        ? Image.memory(
                            itemProvider.imageFile!,
                            fit: BoxFit.fill,
                          )
                        : Container(),
                    const SizedBox(height: 8),
                    CustomTextButton(
                      labelText: '画像取得',
                      backgroundColor: Colors.cyan,
                      onPressed: () async {
                        await itemProvider.imagePicker();
                      },
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField2(
                      controller: itemProvider.numberController,
                      keyboardType: TextInputType.name,
                      labelText: '商品番号',
                      iconData: Icons.numbers,
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField2(
                      controller: itemProvider.nameController,
                      keyboardType: TextInputType.name,
                      labelText: '商品名',
                      iconData: Icons.short_text,
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField2(
                      controller: itemProvider.priceController,
                      keyboardType: TextInputType.number,
                      labelText: '販売価格',
                      iconData: Icons.price_change,
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField2(
                      controller: itemProvider.unitController,
                      keyboardType: TextInputType.name,
                      labelText: '単位',
                      iconData: Icons.archive,
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField2(
                      controller: itemProvider.descriptionController,
                      keyboardType: TextInputType.multiline,
                      labelText: '説明',
                      iconData: Icons.description,
                    ),
                    const SizedBox(height: 8),
                    SwitchList(
                      labelText: '商品情報を公開する',
                      value: itemProvider.openController,
                      onChanged: (value) => itemProvider.openChange(value),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundButton(
                          labelText: '追加する',
                          labelColor: Colors.white,
                          backgroundColor: Colors.blue.shade400,
                          onPressed: () async {
                            String? errorText = await itemProvider.create(
                              shop: shop,
                            );
                            if (errorText != null) {
                              showDialog(
                                context: context,
                                builder: (_) => ErrorDialog(
                                  message: errorText,
                                ),
                              );
                              return;
                            }
                            itemProvider.clearController();
                            if (!mounted) return;
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
