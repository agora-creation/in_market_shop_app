import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/style.dart';
import 'package:in_market_shop_app/models/shop_item.dart';
import 'package:in_market_shop_app/providers/item.dart';
import 'package:in_market_shop_app/widgets/custom_text_form_field2.dart';
import 'package:in_market_shop_app/widgets/error_dialog.dart';
import 'package:in_market_shop_app/widgets/round_button.dart';
import 'package:in_market_shop_app/widgets/switch_list.dart';
import 'package:provider/provider.dart';

class ItemDetailScreen extends StatefulWidget {
  final ShopItemModel item;

  const ItemDetailScreen({required this.item, Key? key}) : super(key: key);

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('${widget.item.name}の詳細'),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await itemProvider.imagePicker();
                          },
                          child: SizedBox(
                            width: 300,
                            height: 200,
                            child: itemProvider.imageFile != null
                                ? Image.memory(
                                    itemProvider.imageFile!,
                                    fit: BoxFit.fitWidth,
                                  )
                                : widget.item.imageUrl != ''
                                    ? Image.network(
                                        widget.item.imageUrl,
                                        fit: BoxFit.fitWidth,
                                      )
                                    : Image.asset(
                                        noImagePath,
                                        fit: BoxFit.fitWidth,
                                      ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundButton(
                          labelText: '一覧に戻る',
                          labelColor: Colors.white,
                          backgroundColor: Colors.grey,
                          onPressed: () => Navigator.pop(context),
                        ),
                        RoundButton(
                          labelText: '削除する',
                          labelColor: Colors.white,
                          backgroundColor: Colors.red.shade400,
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
                            if (!mounted) return;
                            Navigator.pop(context);
                          },
                        ),
                        RoundButton(
                          labelText: '変更内容を保存',
                          labelColor: Colors.white,
                          backgroundColor: Colors.blue.shade400,
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
