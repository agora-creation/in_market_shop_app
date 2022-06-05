import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardCard extends StatelessWidget {
  final int crossAxisCellCount;
  final int mainAxisCellCount;
  final IconData? iconData;
  final String? labelText;
  final int count;
  final Function()? onTap;

  const DashboardCard({
    this.crossAxisCellCount = 1,
    this.mainAxisCellCount = 1,
    this.iconData,
    this.labelText,
    this.count = 0,
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
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              count != 0
                  ? Padding(
                      padding: const EdgeInsets.all(8),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Chip(
                          backgroundColor: Colors.red.shade400,
                          label: Text(
                            '$count',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SourceHanSans-Bold',
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      iconData,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Text(
                  labelText ?? '',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceHanSans-Bold',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
