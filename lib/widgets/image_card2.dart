import 'package:flutter/material.dart';

class ImageCard2 extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? subTitle;
  final Function()? onTap;
  final Widget? child;

  const ImageCard2({
    required this.imageUrl,
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
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: Ink.image(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Text(title),
          ),
        ],
      ),
    );
    // return Container(
    //   decoration: BoxDecoration(
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.grey.withOpacity(0.7),
    //         spreadRadius: 0.1,
    //         offset: const Offset(0.4, 0.5),
    //       ),
    //     ],
    //     borderRadius: BorderRadius.circular(4),
    //     color: Colors.white,
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       GestureDetector(
    //         onTap: onTap,
    //         child: SizedBox(
    //           width: 300,
    //           height: 200,
    //           child: imageUrl != ''
    //               ? Image.network(
    //                   imageUrl,
    //                   fit: BoxFit.cover,
    //                 )
    //               : Image.asset(
    //                   noImagePath,
    //                   fit: BoxFit.cover,
    //                 ),
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(16),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               title,
    //               style: const TextStyle(
    //                 fontSize: 16,
    //                 fontWeight: FontWeight.bold,
    //                 fontFamily: 'SourceHanSans-Bold',
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ),
    //             subTitle != null ? const SizedBox(height: 4) : Container(),
    //             subTitle != null
    //                 ? Text(
    //                     subTitle ?? '',
    //                     style: const TextStyle(
    //                       color: Colors.grey,
    //                       fontSize: 13,
    //                       fontWeight: FontWeight.bold,
    //                       fontFamily: 'SourceHanSans-Bold',
    //                     ),
    //                   )
    //                 : Container(),
    //           ],
    //         ),
    //       ),
    //       child ?? Container(),
    //     ],
    //   ),
    // );
  }
}
