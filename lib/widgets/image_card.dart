import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subTitle;
  final Function()? onTap;

  const ImageCard({
    this.image,
    this.title,
    this.subTitle,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 20 / 13,
              child: image != null
                  ? Image.network(
                      image!,
                      fit: BoxFit.fitWidth,
                    )
                  : Image.asset(
                      'assets/images/no_image.png',
                      fit: BoxFit.fitWidth,
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SourceHanSans-Bold',
                      ),
                    ),
                    subTitle != null ? const SizedBox(height: 4) : Container(),
                    subTitle != null
                        ? Text(
                            subTitle ?? '',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SourceHanSans-Bold',
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
