import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}

class ShoppingCartItem {
  final Product product;
  int quantity;

  ShoppingCartItem(this.product, this.quantity);
}

class ShoppingCart {
  List<ShoppingCartItem> items = [];
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [
    Product("Product 1", 10.0),
    Product("Product 2", 15.0),
    Product("Product 3", 20.0),
  ];

  ShoppingCart cart = ShoppingCart();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: _buildQuantityPicker(product),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add logic to navigate to the cart screen or perform other actions
          // For simplicity, we'll just print the items in the cart
          print(cart.items);
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  Widget _buildQuantityPicker(Product product) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            _updateCart(product, -1);
          },
        ),
        const Text('0'), // Replace with the actual quantity (can be a variable)
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            _updateCart(product, 1);
          },
        ),
      ],
    );
  }

  void _updateCart(Product product, int quantityChange) {
    setState(() {
      var existingItem = cart.items.firstWhere(
        (item) => item.product == product,
      );

      if (existingItem != null) {
        existingItem.quantity += quantityChange;
      } else {
        if (quantityChange > 0) {
          cart.items.add(ShoppingCartItem(product, 1));
        }
      }
    });
  }
}

void main() {
  runApp(const MaterialApp(
    home: ProductListScreen(),
  ));
}
