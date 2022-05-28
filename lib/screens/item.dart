import 'package:flutter/material.dart';
import 'package:in_market_shop_app/widgets/custom_text_button.dart';
import 'package:in_market_shop_app/widgets/custom_text_form_field2.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('商品一覧'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: const Center(child: Text('ありません')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const AddDialog(),
          );
        },
        label: const Text('商品追加'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
    );
  }
}

class AddDialog extends StatelessWidget {
  const AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('商品追加')),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                CustomTextFormField2(
                  controller: TextEditingController(),
                  keyboardType: TextInputType.name,
                  labelText: '商品番号',
                  iconData: Icons.numbers,
                ),
                const SizedBox(height: 16),
                CustomTextFormField2(
                  controller: TextEditingController(),
                  keyboardType: TextInputType.name,
                  labelText: '商品名',
                  iconData: Icons.short_text,
                ),
                const SizedBox(height: 16),
                CustomTextFormField2(
                  controller: TextEditingController(),
                  keyboardType: TextInputType.number,
                  labelText: '販売価格',
                  iconData: Icons.price_change,
                ),
                const SizedBox(height: 16),
                CustomTextFormField2(
                  controller: TextEditingController(),
                  keyboardType: TextInputType.name,
                  labelText: '単位',
                  iconData: Icons.archive,
                ),
                const SizedBox(height: 16),
                CustomTextFormField2(
                  controller: TextEditingController(),
                  keyboardType: TextInputType.multiline,
                  labelText: '説明',
                  iconData: Icons.short_text,
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('公開する'),
                  secondary: const Icon(Icons.visibility),
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextButton(
                  labelText: 'キャンセル',
                  backgroundColor: Colors.grey,
                  onPressed: () => Navigator.pop(context),
                ),
                CustomTextButton(
                  labelText: '追加する',
                  backgroundColor: Colors.blue,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
