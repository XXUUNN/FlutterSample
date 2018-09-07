import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MainAppPage());

class MainAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainAppPageStateful(),
      theme: ThemeData.light(),
      title: 'interactivity',
    );
  }
}

class MainAppPageStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InputTestState();
  }
}

/**
 * Gesture  Detector给child 增加 交互
 */
class ClickTestState extends State<MainAppPageStateful> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
  bool _isLongPressed = false;

  _favorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  _handleTap() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }

  void _doubleTap() {
    setState(() {
      _favoriteCount += 10;
    });
  }

  _longPress(){
    setState(() {
      _isLongPressed = !_isLongPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.zero,
                child: IconButton(
                  icon: _isFavorited
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  onPressed: _favorite,
                ),
              ),
              new SizedBox(
                width: 18.0,
                child: new Container(
                  child: new Text('$_favoriteCount'),
                ),
              ),
              GestureDetector(
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  alignment: Alignment.center,
                  child: Text(
                    '点击',
                    style: TextStyle(color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    color: _isFavorited ? Colors.red : Colors.blueAccent,
                    border: Border.all(color: _isLongPressed?Colors.greenAccent:Colors.yellow)
                  ),
                ),
                onTap: _handleTap,
                onDoubleTap: _doubleTap,
                onLongPress: _longPress,
              )
            ],
          ),
        ));
  }
}


class InputTestState extends State<MainAppPageStateful>{


  String text = 'clickInfoclickInfoclickInfoclickInfoclickInfoclickInfoclickInfo';

  void clickTest() {
    setState(() {
      text = text+'click';
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body:
        Center(
          child: InkWell(child: Container(

            child: Text(text,),
            width: 300.0,
            height: 100.0,
          ),onTap: clickTest ,)
        )
        ,
    );

  }

}
