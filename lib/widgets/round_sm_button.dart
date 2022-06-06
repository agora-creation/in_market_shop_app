import 'package:flutter/material.dart';

class RoundSmButton extends StatelessWidget {
  final String? labelText;
  final Color? labelColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Function()? onPressed;

  const RoundSmButton({
    this.labelText,
    this.labelColor,
    this.backgroundColor,
    this.borderColor,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        side: borderColor != null
            ? BorderSide(color: borderColor ?? const Color(0xFF000000))
            : null,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Text(
          labelText ?? '',
          style: TextStyle(
            color: labelColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceHanSans-Bold',
          ),
        ),
      ),
    );
  }
}
