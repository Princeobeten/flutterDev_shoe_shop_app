import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop_app/providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize = 0;

  void onTap() {
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct(
      {
        'id': widget.product['id'],
        'title':  widget.product['title'],
        'price': widget.product['price'],
        'imageUrl':  widget.product['imageUrl'],
        'company':  widget.product['company'],
        'size':  selectedSize
      }); 
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(child: Text('Product added successfully!'))
      ));
    } else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(child: Text('Please select a size!'))
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Details'),),
      body: Column(
        children: [
          Center(child: Text(widget.product['title'].toString(), style: Theme.of(context).textTheme.titleLarge,)),
          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(widget.product['imageUrl'].toString(), height: 250,),
          ), const Spacer(flex: 2,), 

          Container( height: 250, decoration: BoxDecoration(
            color: const Color.fromRGBO(245, 247, 249, 1),
            borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column( mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('\$${widget.product['price'].toString()}', style: Theme.of(context).textTheme.titleLarge,), const SizedBox(height: 10,),
                
                SizedBox( height: 50, 
                  child: ListView.builder( scrollDirection: Axis.horizontal, itemCount: (widget.product['sizes'] as List<int>).length, 
                  itemBuilder: (context, index) {
                      final size = (widget.product['sizes'] as List<int>)[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: Chip(label: Text(size.toString()), 
                            backgroundColor: selectedSize == size ? Theme.of(context).primaryColor : null,
                          ),
                        )
                      ); 
                    }
                  ),
                ),
              
                ElevatedButton(onPressed: onTap, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor, 
                  fixedSize: const Size(350, 50), 
                ),
                child: const Text('Add To Cart', style: TextStyle(
                  color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600
                ),))
              ]),
            ),
          )
        ],
      ),
    );
  }
}
