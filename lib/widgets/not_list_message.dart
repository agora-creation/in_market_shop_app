import 'package:flutter/material.dart';

class NotListMessage extends StatelessWidget {
  final String? message;

  const NotListMessage({this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message ?? '',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'SourceHanSans-Bold',
        ),
      ),
    );
  }
}
