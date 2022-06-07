import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/style.dart';

class RadioList extends StatelessWidget {
  final String? labelText;
  final dynamic value;
  final dynamic groupValue;
  final Function(dynamic)? onChanged;

  const RadioList({
    this.labelText,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorder,
      child: RadioListTile(
        title: Text(
          labelText ?? '',
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 18,
          ),
        ),
        value: value,
        groupValue: groupValue,
        activeColor: Colors.lightBlue,
        onChanged: onChanged,
      ),
    );
  }
}
