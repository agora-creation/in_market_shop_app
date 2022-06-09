import 'package:flutter/material.dart';

class SwitchList extends StatelessWidget {
  final String? labelText;
  final bool value;
  final Function(bool)? onChanged;

  const SwitchList({
    this.labelText,
    required this.value,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      tileColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(labelText ?? ''),
      secondary: const Icon(Icons.visibility),
      value: value,
      onChanged: onChanged,
    );
  }
}
