import 'package:flutter/material.dart';
import 'package:fluttersliverdemo/custom_sliver_appbar.dart';
import 'package:fluttersliverdemo/nestedscrollView_demo.dart';
import 'package:fluttersliverdemo/sliver_appbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sliver Demo",
      home: Scaffold(
        appBar: AppBar(title: Text("Sliver Demo"),),
        body: SliverDemo(),
      ),
    );
  }
}

class SliverDemo extends StatelessWidget {

  List<String> _titles = ["普通的","自定义","与TabBar配合使用"];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemBuilder: (BuildContext context,int index){
          return InkWell(
            child: Container(
              height: 50,
              child: Center(child: Text(_titles[index]),),
            ),
            onTap: (){
              Widget push = null;
              if(index == 0){
                push = SliverAppBarDemo();
              }else if(index == 1){
                push = CustomSliverAppBarDemo();
              }else{
                push = NestedScrollViewDemo();
              }
              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return push;
                  }
              ));
            },
          );
        },
        itemCount: 3,
        separatorBuilder: (BuildContext context,int index){
          return Divider(height: 1.0,);
        },
      ),
    );
  }
}

