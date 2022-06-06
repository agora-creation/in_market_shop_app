import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/style.dart';

class CustomCheckbox extends StatelessWidget {
  final String? labelText;
  final bool? value;
  final Function(bool?)? onChanged;

  const CustomCheckbox({
    this.labelText,
    this.value,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorder,
      child: CheckboxListTile(
        title: Text(
          labelText ?? '',
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 18,
          ),
        ),
        activeColor: Colors.blue,
        controlAffinity: ListTileControlAffinity.leading,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
