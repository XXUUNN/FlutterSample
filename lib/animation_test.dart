import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show LengthLimitingTextInputFormatter, rootBundle;

class AnimatedListSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AnimatedListState();
  }
}

class _AnimatedListState extends State<AnimatedListSample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel<int> _list;
  int _selectedItem;
  int _nextItem;

  @override
  void initState() {
    super.initState();

    _list = new ListModel<int>(
      listKey: _listKey,
      initialItems: <int>[0, 1, 2],
      removedItemBuilder: _buildRemovedItem,
    );
    _nextItem = 3;
  }

  Widget _buildRemovedItem(
      int item, BuildContext context, Animation<double> animation) {
    return new CardItem(
      animation: animation,
      item: item,
      selected: false,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('animatedList'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: _insert,
              tooltip: 'insert a new item',
            ),
            IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: _remove,
              tooltip: 'remove a new item',
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: AnimatedList(
              key: _listKey,
              initialItemCount: _list.length,
              itemBuilder: _buildItem),
        ),
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      item: _list[index],
      animation: animation,
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      },
    );
  }

  _insert() {
    final int index =
        _selectedItem == null ? _list.length : _list.indexOf(_selectedItem);
    _list.insert(index, _nextItem++);
  }

  _remove() {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem));
      setState(() {
        _selectedItem = null;
      });
    }
  }
}

class ListModel<E> {
  final List<E> _items;
  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;

  int get length => _items.length;

  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = new List<E>.from(
          initialItems ?? <E>[],
        );

  AnimatedListState get _animateList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animateList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animateList.removeItem(index,
          (BuildContext context, Animation<double> animation) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
    return removedItem;
  }

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

class CardItem extends StatelessWidget {
  CardItem(
      {Key key,
      @required this.animation,
      this.onTap,
      @required this.item,
      this.selected: false, })
      : assert(animation != null),
        assert(item != null && item >= 0),
        assert(selected != null),
        super(key: key){
    controller = TextEditingController();
  }

  TextEditingController controller;
  final Animation<double> animation;
  final VoidCallback onTap;
  final int item;
  final bool selected;

  bool isShow = false;


  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).accentTextTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(
          color: Colors.lightGreenAccent[400], fontFamily: 'test');

    return Padding(
        padding: EdgeInsets.all(2.0),
        child: new GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: new SizedBox(
            height: 200.0,
            child: new Card(
              color: Colors.primaries[item % Colors.primaries.length],
              child: new Center(
                  child: Column(
                children: <Widget>[
                  new Text('中国$item', style: textStyle),
                  TextField(
                    inputFormatters: [LengthLimitingTextInputFormatter(5)],
                    decoration: InputDecoration(
                        hintText: 'hit',
                        labelText: 'fffff',
                        suffixIcon: Icon(Icons.print)),
                    controller: controller,
                  ),
                  RaisedButton(onPressed: () {
//                    if(!isShow){
                      if(controller.text == null || controller.text.length == 0){
                        return;
                      }
                      showBottomSheet(context: context, builder:(context){
                        return Text(controller.text);
                      });
//                      isShow = true;
//                    }else{
//                      Navigator.of(context).pop();
//                      isShow =false;
//                    }

                  },),
                ],
              )),
            ),
          ),
        ));
  }
}

void main() => runApp(AnimatedListSample());
