import 'package:flutter/material.dart';

class NestedScrollViewDemo extends StatelessWidget {
  TabController _controller = TabController(
    length: 2, //Tab页数量
    vsync: ScrollableState(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("你好"),),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context,bool innerBoxIsScrolled){
          return [
            SliverAppBar( // 滑动会停留 固定高度为导航栏的高度，不设置 expandedHeight跟普通的差不多
              title: Text("你好"),
              pinned: true,
              flexibleSpace: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: PageView(),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.orangeAccent,
                child: Container(
                  height: 200,
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                  child: TabBar(
                    labelColor: Colors.black,
                    controller: _controller,
                    tabs: <Widget>[
                      Tab(text: "热门",),
                      Tab(text: "推荐",)
                    ],
                  )
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _controller,
          children: <Widget>[
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.separated(
                itemBuilder: (BuildContext context,int index){
                  return Container(height: 50,);
                },
                itemCount: 30,
                separatorBuilder: (BuildContext context,int index){
                  return Divider(color: Colors.redAccent,);
                },
              ),
            ),
            ListView.separated(
              itemBuilder: (BuildContext context,int index){
                return Container(height: 50,);
              },
              itemCount: 30,
              separatorBuilder: (BuildContext context,int index){
                return Divider(color: Colors.redAccent,);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}