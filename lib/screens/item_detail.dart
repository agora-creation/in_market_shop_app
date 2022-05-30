import 'package:flutter/material.dart';
import 'package:in_market_shop_app/models/shop_item.dart';
import 'package:in_market_shop_app/providers/item.dart';
import 'package:in_market_shop_app/widgets/custom_text_button.dart';
import 'package:in_market_shop_app/widgets/custom_text_form_field2.dart';
import 'package:in_market_shop_app/widgets/error_dialog.dart';
import 'package:provider/provider.dart';

class ItemDetailScreen extends StatefulWidget {
  final ShopItemModel item;
  const ItemDetailScreen({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          '${widget.item.name}の詳細',
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
        children: [
          CustomTextFormField2(
            controller: itemProvider.numberController,
            keyboardType: TextInputType.name,
            labelText: '商品番号',
            iconData: Icons.numbers,
          ),
          const SizedBox(height: 16),
          CustomTextFormField2(
            controller: itemProvider.nameController,
            keyboardType: TextInputType.name,
            labelText: '商品名',
            iconData: Icons.short_text,
          ),
          const SizedBox(height: 16),
          CustomTextFormField2(
            controller: itemProvider.priceController,
            keyboardType: TextInputType.number,
            labelText: '販売価格',
            iconData: Icons.price_change,
          ),
          const SizedBox(height: 16),
          CustomTextFormField2(
            controller: itemProvider.unitController,
            keyboardType: TextInputType.name,
            labelText: '単位',
            iconData: Icons.archive,
          ),
          const SizedBox(height: 16),
          CustomTextFormField2(
            controller: itemProvider.descriptionController,
            keyboardType: TextInputType.multiline,
            labelText: '説明',
            iconData: Icons.description,
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            tileColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text('商品情報を公開する'),
            secondary: const Icon(Icons.visibility),
            value: itemProvider.openController,
            onChanged: (value) => itemProvider.openChange(value),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                labelText: 'キャンセル',
                backgroundColor: Colors.grey,
                onPressed: () => Navigator.pop(context),
              ),
              Row(
                children: [
                  CustomTextButton(
                    labelText: '削除する',
                    backgroundColor: Colors.red,
                    onPressed: () async {
                      String? errorText = await itemProvider.delete(
                        item: widget.item,
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
                  const SizedBox(width: 8),
                  CustomTextButton(
                    labelText: '更新する',
                    backgroundColor: Colors.blue,
                    onPressed: () async {
                      String? errorText = await itemProvider.update(
                        item: widget.item,
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
        ],
      ),
    );
  }
}
