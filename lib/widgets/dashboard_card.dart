import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardCard extends StatelessWidget {
  final int crossAxisCellCount;
  final int mainAxisCellCount;
  final String? labelText;
  final Function()? onTap;

  const DashboardCard({
    this.crossAxisCellCount = 1,
    this.mainAxisCellCount = 1,
    this.labelText,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: crossAxisCellCount,
      mainAxisCellCount: mainAxisCellCount,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: Colors.white,
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_bag,
                color: Colors.blue,
              ),
              Text(labelText ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
