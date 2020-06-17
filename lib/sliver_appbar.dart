import 'package:flutter/material.dart';

class SliverAppBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // 固定的AppBar
          SliverAppBar( // 滑动会停留固定高度为导航栏的高度，不设置 expandedHeight跟普通的AppBar差不多
            elevation: 0.0,
            title: Text("Sliver Demo"),
            centerTitle: true,
            // 展开的高度
            expandedHeight: 200,
            // 强制显示阴影
            forceElevated: false,
            // 设置该属性，当有下滑手势的时候，就会显示 AppBar
            floating: true,
            // 该属性只有在 floating 为 true 的情况下使用，不然会报错
            // 当上滑到一定的比例，会自动把 AppBar 收缩（不知道是不是 bug，当 AppBar 下面的部件没有被 AppBar 覆盖的时候，不会自动收缩）
            // 当下滑到一定比例，会自动把 AppBar 展开
            snap: true,
            // 设置该属性使 Appbar 折叠后不消失，一直会存在界面上
            pinned: true,
            // 通过这个属性设置 AppBar 的背景
            flexibleSpace: FlexibleSpaceBar(
             // title: Text("Expanded Title"),
              // 背景折叠动画
              collapseMode: CollapseMode.parallax,
              background: Image.asset("assets/image/home_header_bg.png",fit: BoxFit.cover,),
            ),
          ),
          // 这个部件一般用于最后填充用的，会占有一个屏幕的高度，可以在 child 属性加入需要展示的部件
          // SliverFillViewport
          // SliverFixedExtentList
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
