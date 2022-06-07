import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/style.dart';

class SelectList extends StatelessWidget {
  final String? labelText;
  final bool checked;
  final Function()? onTap;

  const SelectList({
    this.labelText,
    this.checked = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorder,
      child: ListTile(
        leading: checked == true
            ? const Icon(Icons.check_circle, color: Colors.lightBlue)
            : const Icon(Icons.circle_outlined),
        title: Text(
          labelText ?? '',
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 18,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
