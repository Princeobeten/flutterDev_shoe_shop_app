import 'package:flutter/material.dart';
import 'package:shoe_shop_app/pages/cart_page.dart';
import 'package:shoe_shop_app/widgets/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  List<Widget> pages = const [ProductList(), CartPage(), ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack(index: currentPage, children: pages),
      bottomNavigationBar: BottomNavigationBar( currentIndex: currentPage, iconSize: 35,
      selectedFontSize: 0, unselectedFontSize: 0,
      onTap: (value) {
        setState(() {
          currentPage = value;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_checkout_rounded), label: '')
      ],
      ),
    );
  }
}


// 18:38:02