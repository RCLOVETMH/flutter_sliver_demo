import 'package:flutter/material.dart';

class CustomSliverAppBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // 自定义的
          SliverPersistentHeader(delegate: DemoHeader(), pinned: true,),

          SliverFillRemaining(
            child: Center(
              child: Text("你好世界！"),
            ),
          )
        ],
      ),
    );
  }
}

class DemoHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Colors.pink,
        alignment: Alignment.center,
        child: Text('我是一个头部部件', style: TextStyle(color: Colors.white, fontSize: 30.0))
    );
  } // 头部展示内容

  @override
  double get maxExtent => 200.0; // 最大高度

  @override
  double get minExtent => 100.0; // 最小高度

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false; // 因为所有的内容都是固定的，所以不需要更新
}

/*
// 自定义 SliverPersistentHeaderDelegate
class CustomSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double max; // 最大高度
  final double min; // 最小高度
  final Widget child; // 需要展示的内容

  CustomSliverPersistentHeaderDelegate({@required this.max, @required this.min, @required this.child})
  // 如果 assert 内部条件不成立，会报错
      : assert(max != null),
        assert(min != null),
        assert(child != null),
        assert(min <= max),
        super();

  // 返回展示的内容，如果内容固定可以直接在这定义，如果需要可扩展，这边通过传入值来定义
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => child;

  @override
  double get maxExtent => max; // 返回最大高度

  @override
  double get minExtent => min; // 返回最小高度

  @override
  bool shouldRebuild(CustomSliverPersistentHeaderDelegate oldDelegate) {
    // 是否需要更新，这里我们定义当高度范围和展示内容被替换的时候进行刷新界面
    return max != oldDelegate.max || min != oldDelegate.min || child != oldDelegate.child;
  }
}
 */