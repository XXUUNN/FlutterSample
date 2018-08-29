import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MainAppPage());

class MainAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ClickTestState();
  }
}

class ClickTestState extends State<MainAppPage> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  _favorite(){
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.zero,
          child: IconButton(
            icon: _isFavorited?Icon(Icons.favorite):Icon(Icons.favorite_border),
            onPressed: _favorite,
          ),
        ),
        new SizedBox(
          width: 18.0,
          child: new Container(
            child: new Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}
