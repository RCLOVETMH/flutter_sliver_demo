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