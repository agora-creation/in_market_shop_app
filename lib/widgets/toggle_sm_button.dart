import 'package:flutter/material.dart';

class ToggleSmButton extends StatelessWidget {
  final String labelText;
  final Function()? removeOnTap;
  final Function()? addOnTap;

  const ToggleSmButton({
    required this.labelText,
    this.removeOnTap,
    this.addOnTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade400),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: removeOnTap,
            icon: Icon(
              Icons.remove,
              color: Colors.blue.shade400,
              size: 20,
            ),
          ),
          Text(
            labelText,
            style: TextStyle(
              color: Colors.blue.shade400,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'SourceHanSans-Bold',
            ),
          ),
          IconButton(
            onPressed: addOnTap,
            icon: Icon(
              Icons.add,
              color: Colors.blue.shade400,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
