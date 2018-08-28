import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 入口
 */
void main() => runApp(new ShowHideTestPage());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(primaryColor: Colors.white),
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  final _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _createSuggestions(),
    );
  }

  Widget _createSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        if (index.isOdd) return new Divider();

        final i = index ~/ 2;
        if (i >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[i]);
      },
    );
  }

  Widget _buildRow(WordPair suggestion) {
    final isSaved = _saved.contains(suggestion);

    return new ListTile(
      title: new Text(
        suggestion.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        isSaved ? Icons.favorite : Icons.favorite_border,
        color: isSaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          isSaved ? _saved.remove(suggestion) : _saved.add(suggestion);
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
              .divideTiles(
                context: context,
                tiles: tiles,
              )
              .toList();
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}

class UITestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    "Oeschinen Lake Campground",
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                new Text(
                  'Kandersteg, Switzerland',
                  style: new TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
          new Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          new Text('41'),
        ],
      ),
    );

    Column buildButtonColumn(IconData icon, String label) {
      var color = Theme.of(context).primaryColor;
      return new Column(
        children: <Widget>[
          new Icon(
            icon,
            color: color,
          ),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.call, 'CALL'),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget textSection = new Container(
      padding: const EdgeInsets.all(64.0),
      child: new Text(
        '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,
      ),
    );

    return new MaterialApp(
      home: new Scaffold(
        body: new ListView(
          children: <Widget>[
            new Image.asset(
              'images/icon_eat.jpg',
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
      title: "UI test",
      theme: new ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class ShowHideTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'showHideTest',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new ShowHideWidget(),
    );
  }
}

class ShowHideWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CupertinoTestState();
  }
}

class ShowHideState extends State<ShowHideWidget> {
  bool isShow = true;
  bool isPress = false;

  switchState() {
    setState(() {
      isPress = true;
      isShow = !isShow;
    });
  }

  /**
   * 显示dialog
   * dart下划线开头表示私有  相当于private
   */
  _myShowDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('title'),
            content: new Text('content'),
            actions: <Widget>[
              new FlatButton(
                child: new Text('cancle'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  /**
   * expanded 有flex 权重布局
   */
  _getFlexImage(String path, int flex) {
//    return new Expanded(
//      child: new Icon(Icons.add),
//      flex: flex,
//    );
    return new Icon(Icons.add);
  }

  /**
   * container 才能加 padding margin
   */
  _getChild() {
    if (isShow) {
      return new Container(
          padding: EdgeInsets.only(left: -0.0),
          child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//            new Text('666'),
//            new Text('77777\n7777'),
//                new Image.network(
//                  "https://ss3.baidu.com/9fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=c4b4d6dff01f4134ff37037e151e95c1/c995d143ad4bd113115afc0e57afa40f4bfb0572.jpg",
//                  width: 50.0,
//                ),
                new RaisedButton.icon(
                    onPressed: _myShowDialog,
                    icon: new Icon(Icons.print),
                    label: new Text("raiseBtn"))
              ]));
    } else {
      return new Center(
          child: new Container(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _getFlexImage('images/icon_eat.jpg', 1),
            _getFlexImage('images/icon_eat.jpg', 2),
            _getFlexImage('images/icon_eat.jpg', 1),
          ],
        ),
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
        ),
      ));
    }
  }

  /**
   * tooltip 长按空间会显示
   */
  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = new Scaffold(
      appBar: new AppBar(
        title: new Text('showHide'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.update), onPressed: null),
          new PopupMenuButton(
            itemBuilder: (BuildContext context) {
              var item = new PopupMenuItem(child: new Text('fff'));
              List<PopupMenuItem> list = List.from([item]);
              list.add(item);
              return list;
            },
            tooltip: '菜单',
          )
        ],
      ),
      backgroundColor: Colors.blueAccent,
      body: _getChild(),
      floatingActionButton: new FloatingActionButton(
        onPressed: switchState,
        tooltip: 'showAndHide',
        child: new Icon(Icons.update),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      drawer: new Drawer(),
    );

    return scaffold;
  }
}

class WidgetTestState extends State<ShowHideWidget> {
  /**
   * stack 能重叠覆盖
   * alignment  x 从左到右(-1~1)  y  从上到下(-1~1)
   * CircleAvatar的radius半径大小
   * Colors.black45  黑45不透明度
   */
  _getStackTest() {
    return new Container(
      height: 300.0,
      width: 300.0,
//      alignment: Alignment(1.0, -1.0),//只有child有效，stack的第一个控件
      child: new Stack(
//        alignment: Alignment(1.0, -1.0),//stack内的所有控件都有效果 相对于父布局位置
        children: <Widget>[
          new CircleAvatar(
            backgroundColor: new Color.fromARGB(54, 0, 0, 0),
            backgroundImage: new AssetImage('images/test.jpg'),
            radius: 120.0,
          ),
          new Container(
//              alignment: Alignment(1.0, -1.0),
            padding: EdgeInsets.all(10.0),
            decoration: new BoxDecoration(
              color: Colors.black45,
              borderRadius:
                  new BorderRadius.only(topLeft: Radius.circular(10.0)),
            ),
            margin: EdgeInsets.only(left: 50.0, top: 50.0),
            child: new Text(
              'text',
              style: new TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'WidgetTest',
          style: new TextStyle(
            inherit: true,
            color: Colors.greenAccent,
          ),
        ),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getStackTest(),
        ],
      ),
    );
  }
}

/**
 * gridView
 *
 * maxCrossAxisExtent 交叉方向（和主方向垂直）的最大item长度、
 * mainAxisSpacing 间隔线
 * scrollDirection 主方向的方向  横向或者纵向
 */
class GridViewTestState extends State<ShowHideWidget> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: _buildGrid(),
      color: Colors.red,
    );
  }

  _buildGrid() {
    return new GridView.extent(
      maxCrossAxisExtent: 150.0,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      children: _buildGridItem(30),
      scrollDirection: Axis.horizontal,
    );
  }

  _buildGridItem(int count) {
    return new List<Container>.generate(
        count,
        (int index) => new Container(
              color: Colors.white,
              child: Image.asset(
                'images/test.jpg',
                fit: BoxFit.fill,
              ),
            ));
  }
}

/**
 * 列表item常用  有阴影  圆角
 */
class CardTestState extends State<ShowHideWidget> {
  _buildCard() {
    return new Scaffold(
      body: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            new ListTile(
              title: new Text('1625 Main Street',
                  style: new TextStyle(fontWeight: FontWeight.w500)),
              subtitle: new Text('My City, CA 99984'),
              leading: new Icon(
                Icons.restaurant_menu,
                color: Colors.blue[500],
              ),
            ),
            new Divider(),
            new ListTile(
              title: new Text('(408) 555-1212',
                  style: new TextStyle(fontWeight: FontWeight.w500)),
              leading: new Icon(
                Icons.contact_phone,
                color: Colors.blue[500],
              ),
            ),
            new ListTile(
              title: new Text('costa@example.com'),
              leading: new Icon(
                Icons.contact_mail,
                color: Colors.blue[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCard();
  }
}

/**
 * 底部导航栏  页面切换
 * currentIndex 值变化 底部按钮UI变化
 */
class BottomBarTestState extends State<ShowHideWidget> {
  int _curIndex = 0;
  var _pageController = PageController(initialPage: 0);

  _buildBottomItem() {
    return List<BottomNavigationBarItem>.generate(
        3,
        (int i) => BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm), title: new Text(i.toString())));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('bottomNavigationBarTest'),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: _buildBottomItem(),
        onTap: (index) {
//          _pageController.jumpToPage(index);
          _pageController.animateToPage(index,
              duration: Duration(seconds: 2), curve: ElasticOutCurve(0.8));
        },
        currentIndex: _curIndex,
      ),
      body: PageView.builder(
          itemCount: 3,
          onPageChanged: (index) {
            setState(() {
              if (_curIndex != index) _curIndex = index;
            });
          },
          controller: _pageController,
          itemBuilder: (context, index) {
            return new Text('我是第 ${index} 页');
          }),
    );
  }
}

/**
 * iOS风格的控件
 * CupertinoPageScaffold的navigationBar的高度 没有计算进去  默认是44
 *
 */
class CupertinoTestState extends State<ShowHideWidget> {
  static const int ITEM_COUNT = 3;

  int _curIndex = 0;

  _buildBottomBarItems() {
    var item1 = BottomNavigationBarItem(
        icon: Icon(Icons.access_alarms), title: Text('闹铃'));
    var item2 = BottomNavigationBarItem(
        icon: Icon(Icons.battery_alert), title: Text('电量'));
    var item3 =
        BottomNavigationBarItem(icon: Icon(Icons.cake), title: Text('蛋糕'));
    var items = List<BottomNavigationBarItem>();
    items.add(item1);
    items.add(item2);
    items.add(item3);
    return items;
  }

  /**
   * 保存按钮点击状态
   */
  var _isChange = false;

  /**
   * progress
   */
  var _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: _buildBottomBarItems(),
          onTap: (position) {},
          currentIndex: _curIndex,
        ),
        tabBuilder: (context, index) {
          return new CupertinoTabView(
            builder: (BuildContext context) {
              return new CupertinoPageScaffold(
                navigationBar: new CupertinoNavigationBar(
                  middle: new Text('Page 1 of tab $index'),
                ),
                child: new Column(
                  children: <Widget>[
                    Text('fffffffff'),
                    Text('fffffffff'),
                    CupertinoSwitch(
                      value: _isChange,
                      onChanged: (isChanged) {
                        setState(() {
                          _isChange = !_isChange;
                        });
                      },
                    ),
                    CupertinoSlider(
                      value: _value,
                      onChanged: (double value) {
                        setState(() {
                          _value = value;
                        });
                      },
                      max: 100.0,
                    ),
                    CupertinoButton(
                      child: const Text('Next page'),
                      onPressed: () {
                        Navigator.of(context).push(
                          new CupertinoPageRoute<Null>(
                            builder: (BuildContext context) {
                              return new CupertinoPageScaffold(
                                navigationBar: new CupertinoNavigationBar(
                                  middle: new Text('Page 2 of tab $index'),
                                ),
                                child: new Center(
                                  child: new CupertinoButton(
                                    child: const Text('Back'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
