import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Product {
  final String name;

  const Product(this.name);
}

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  ShoppingListItem({Product product, this.inCart, this.onCartChanged})
      : product = product,
        super(key: ObjectKey(product));

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(
        product.name,
        style: _getTextStyle(context),
      ),
    );
  }

  _getColor(BuildContext context) {
    return !inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  _getTextStyle(BuildContext context) {
    return !inCart
        ? null
        : TextStyle(
            color: Colors.black54,
            decoration: TextDecoration.lineThrough,
          );
  }
}

class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;


  @override
  _ShoppingListState createState() => _ShoppingListState();
}


class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _ShoppingCart = Set<Product>();

  void _cardChanged(Product product, bool inCart) {
    setState(() {
      if (inCart) {
        _ShoppingCart.add(product);
      } else {
        _ShoppingCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return ShoppingListItem(
            product: product,
            inCart: _ShoppingCart.contains(product),
            onCartChanged: _cardChanged,
          );
        }).toList(),
      ),
    );
  }
}

//void main() {
//  runApp(MaterialApp(
//    title: 'shopping app',
//    home: ShoppingList(
//      productList: <Product>[],
//    ),
//  ));
//}

void main() {
  runApp(MaterialApp(
    title: 'Shopping App',
    home: ShoppingList(
      products: <Product>[
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
        Product( 'Eggs'),
        Product('Flour'),
        Product('Chocolate chips'),
      ],
    ),
  ));
}