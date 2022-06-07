import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final IconData? iconData;
  final String? labelText;
  final Function()? onPressed;

  const SearchButton({
    this.iconData,
    this.labelText,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Colors.lightBlue,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      icon: Icon(iconData, color: Colors.white),
      label: Text(
        labelText ?? '',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
