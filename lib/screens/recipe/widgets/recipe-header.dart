import 'package:flutter/material.dart';
import 'package:meal_planner/widgets/measure-size.dart';

class RecipeHeader extends StatefulWidget {
  final child;
  final image;

  const RecipeHeader({Key key, this.child, this.image}) : super(key: key);

  @override
  RecipeHeaderState createState() => RecipeHeaderState();
}

class RecipeHeaderState extends State<RecipeHeader> {
  final GlobalKey stickyKey = GlobalKey();
  double height = 61;

  void checkHeight(Size newSize) {
    if (newSize == null) return;

    if (height != newSize.height) {
      setState(() {
        height = newSize.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;

    return SliverPersistentHeader(
      pinned: true,
      delegate: _HeaderDelegate(
        expandedHeight: 300,
        minHeight: height + top,
        onChange: checkHeight,
        image: widget.image,
        child: widget.child,
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final Widget image;
  final double expandedHeight;
  final double minHeight;
  final OnWidgetSizeChange onChange;

  _HeaderDelegate(
      {@required this.expandedHeight,
      @required this.minHeight,
      @required this.child,
      @required this.image,
      this.onChange});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = 1 - shrinkOffset / expandedHeight;
    final theme = Theme.of(context);
    final radius = Radius.circular(30 * percent);

    return Stack(
      fit: StackFit.expand,
      children: [
        image,
        Positioned(
          left: 0,
          right: 0,
          bottom: -1,
          child: MeasureSize(
              onChange: onChange,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
                  boxShadow: const [
                    const BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: Offset(0, -3), // changes position of shadow
                    ),
                  ],
                ),
                // padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 15),
                child: child,
              )),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight - 1;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate prev) => true;
}
