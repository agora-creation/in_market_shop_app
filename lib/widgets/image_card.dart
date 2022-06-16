import 'package:flutter/material.dart';
import 'package:in_market_shop_app/helpers/style.dart';

class ImageCard extends StatelessWidget {
  final String image;
  final String title;
  final String? subTitle;
  final Function()? onTap;
  final Widget? child;

  const ImageCard({
    required this.image,
    required this.title,
    this.subTitle,
    this.onTap,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: AspectRatio(
              aspectRatio: 20 / 12,
              child: image != ''
                  ? Image.network(
                      image,
                      fit: BoxFit.fitWidth,
                    )
                  : Image.asset(
                      noImagePath,
                      fit: BoxFit.fitWidth,
                    ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSans-Bold',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subTitle != null ? const SizedBox(height: 4) : Container(),
                  subTitle != null
                      ? Text(
                          subTitle ?? '',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SourceHanSans-Bold',
                          ),
                        )
                      : Container(),
                  child != null ? const SizedBox(height: 8) : Container(),
                  child ?? Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
