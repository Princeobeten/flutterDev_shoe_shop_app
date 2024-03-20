import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    return Scaffold(
      appBar: AppBar( centerTitle: true, title: const Text('Cart'),),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];

          return ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(cartItem['imageUrl'] as String), radius: 30,),
            title: Text(cartItem['title'].toString(), style: Theme.of(context).textTheme.bodySmall,),
            subtitle: Text('Size ${cartItem['size'].toString()}'),
            trailing: IconButton(onPressed: () {
              showDialog(barrierDismissible: false, context: context, builder: (context) {
                return AlertDialog(
                  title: Text('Delete Product', style: Theme.of(context).textTheme.titleMedium,),
                  content: Text('Are you sure you want to remove ${cartItem['title']} from our cart?', style: Theme.of(context).textTheme.bodySmall,),
                  actions: [
                    TextButton(onPressed: () {
                      Provider.of<CartProvider>(context, listen: false).removeProduct(cartItem); 
                      Navigator.of(context).pop();
                    }, child: Text('Yes', style: TextStyle(color: Colors.red[900], fontWeight: FontWeight.w700))),
                    TextButton(onPressed: () {Navigator.of(context).pop();}, child: const Text('No', style: TextStyle(color: Colors.blue ,fontWeight: FontWeight.w700)))
                  ],
                );
              });
            }, icon: const Icon(Icons.delete, color: Colors.red,)),
          );
        },
      ),
    );
  }
}




// 19:50:22