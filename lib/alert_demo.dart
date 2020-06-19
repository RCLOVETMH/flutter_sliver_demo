import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class InterestPaperwidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("兴趣测评列表"),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          iconSize: 36,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: FlatButton(
          child: Container(
            height: 100,width: 100,
            color: Colors.redAccent,
          ),
          onPressed: (){
            RCToast.showText("你好世界你好世界你好世界");
            // Toast.toast(context,msg: "你好世界");
            //  Loading.showLoading(context);
            /*
            showDialog(
              context: context,
              builder: (BuildContext context){
                return Center(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    height: 80,
                    width: 80,
                    child: Text("你好",style: TextStyle(fontSize: 15,color: Colors.white,decoration: TextDecoration.none,))
                  ),
                );
              }
             );

             */
          },
        ),
      ),
    );
  }
}

class Loading {
  static bool isShow = false;

  static showLoading(BuildContext context) {
    if (!isShow) {
      isShow = true;
      showGeneralDialog(
          context: context,
          // barrierColor: Colors.white, // 背景色
          // barrierLabel: '',
          barrierDismissible: false, // 是否能通过点击空白处关闭
          transitionDuration: const Duration(milliseconds: 100), // 动画时长
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return Align(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Theme(
                  data: ThemeData(
                    cupertinoOverrideTheme: CupertinoThemeData(
                      brightness: Brightness.dark,
                    ),
                  ),
                  child: CupertinoActivityIndicator(
                    radius: 16,
                  ),
                ),
              ),
            );
          }).then((value) {
        isShow = false;
      });
    }
  }

  static hideLoading(BuildContext context) {
    if (isShow) {
      Navigator.of(context).pop();
    }
  }
}


class RCToast{
  static OverlayEntry _overlayEntry;
  static bool _showing = false;
  static String _text;
  static BuildContext _context;



  static void showText(String text,{BuildContext context }) async {

    if(_showing == true){
      _overlayEntry.remove();
      _overlayEntry = null;
    }

    _text = text;
    //获取OverlayState
    OverlayState overlayState = Overlay.of(GlobalContext);
    _showing = true;

    if (_overlayEntry == null) {
      //OverlayEntry负责构建布局
      //通过OverlayEntry将构建的布局插入到整个布局的最上层
      _overlayEntry = OverlayEntry(
          builder: (BuildContext context) => Positioned(
            //top值，可以改变这个值来改变toast在屏幕中的位置
            top: TopPadding+kToolbarHeight,
            child: Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-kToolbarHeight-TopPadding,
                padding: EdgeInsets.only(bottom: kToolbarHeight+TopPadding),
                child:AnimatedOpacity(
                  opacity: _showing ? 1.0 : 0.0, //目标透明度
                  duration: _showing
                      ? Duration(milliseconds: 100)
                      : Duration(milliseconds: 250),
                  child: _buildToastWidget(),
                )),
          ));
      //插入到整个布局的最上层
      overlayState.insert(_overlayEntry);
    }else {
      //重新绘制UI，类似setState
      _overlayEntry.markNeedsBuild();
    }




    // 等待时间
    await Future.delayed(Duration(milliseconds: 2000));
    _showing = false;
    _overlayEntry.markNeedsBuild();
    await Future.delayed(Duration(milliseconds: 300));
    _overlayEntry.remove();
    _overlayEntry = null;

  }
  static _buildToastWidget() {
    return Center(
      child: Card(
        color: Colors.black87,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 10, vertical: 10),
          child: Text(
            _text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

}


enum ToastPostion{
  top,
  center,
  bottom,
}
class Toast{
  static OverlayEntry _overlayEntry;
  static bool _showing = false;
  static DateTime _startedTime;
  static String _msg;
  // toast显示时间
  static int _showTime;
  // 背景颜色
  static Color _bgColor;
  // 文本颜色
  static Color _textColor;
  // 文字大小
  static double _textSize;
  // 显示位置
  static ToastPostion _toastPosition;
  // 左右边距
  static double _pdHorizontal;
  // 上下边距
  static double _pdVertical;
  static void toast(
      BuildContext context, {
        //显示的文本
        String msg,
        //显示的时间 单位毫秒
        int showTime = 1000,
        //显示的背景
        Color bgColor = Colors.black54,
        //显示的文本颜色
        Color textColor = Colors.white,
        //显示的文字大小
        double textSize = 15.0,
        //显示的位置
        ToastPostion position = ToastPostion.center,
        //文字水平方向的内边距
        double pdHorizontal = 10.0,
        //文字垂直方向的内边距
        double pdVertical = 10.0,
      }) async {
    assert(msg != null);
    _msg = msg;
    _startedTime = DateTime.now();
    _showTime = showTime;
    _bgColor = bgColor;
    _textColor = textColor;
    _textSize = textSize;
    _toastPosition = position;
    _pdHorizontal = pdHorizontal;
    _pdVertical = pdVertical;
    //获取OverlayState
    OverlayState overlayState = Overlay.of(context);
    _showing = true;

    if (_overlayEntry == null) {
      //OverlayEntry负责构建布局
      //通过OverlayEntry将构建的布局插入到整个布局的最上层
      _overlayEntry = OverlayEntry(
          builder: (BuildContext context) => Positioned(
            //top值，可以改变这个值来改变toast在屏幕中的位置
            top: buildToastPosition(context),
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: AnimatedOpacity(
                    opacity: _showing ? 1.0 : 0.0, //目标透明度
                    duration: _showing
                        ? Duration(milliseconds: 100)
                        : Duration(milliseconds: 400),
                    child: _buildToastWidget(),
                  ),
                )),
          ));
      //插入到整个布局的最上层
      overlayState.insert(_overlayEntry);
    } else {
      //重新绘制UI，类似setState
      _overlayEntry.markNeedsBuild();
    }
    // 等待时间
    await Future.delayed(Duration(milliseconds: _showTime));
    _showing = false;
    _overlayEntry.markNeedsBuild();
    await Future.delayed(Duration(milliseconds: 400));
    _overlayEntry.remove();
    _overlayEntry = null;

    /*
    //2秒后 到底消失不消失
    if (DateTime.now().difference(_startedTime).inMilliseconds >= _showTime) {
      _showing = false;
      _overlayEntry.markNeedsBuild();
      print("111111111");
      await Future.delayed(Duration(milliseconds: 400));
      print("222222222");
      _overlayEntry.remove();
      _overlayEntry = null;
    }
     */

  }

  //toast绘制
  static _buildToastWidget() {
    return Center(
      child: Card(
        color: _bgColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: _pdHorizontal, vertical: _pdVertical),
          child: Text(
            _msg,
            style: TextStyle(
              fontSize: _textSize,
              color: _textColor,
            ),
          ),
        ),
      ),
    );
  }

//  设置toast位置
  static buildToastPosition(context) {
    var backResult;
    if (_toastPosition == ToastPostion.top) {
      backResult = MediaQuery.of(context).size.height * 1 / 4;
    } else if (_toastPosition == ToastPostion.center) {
      backResult = MediaQuery.of(context).size.height * 0.45;
    } else {
      backResult = MediaQuery.of(context).size.height * 3 / 4;
    }
    return backResult;
  }
}
