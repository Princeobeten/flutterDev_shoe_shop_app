import 'package:flutter/material.dart';
import 'package:shoe_shop_app/global_variables.dart';
import 'package:shoe_shop_app/pages/product_details_page.dart';
import 'package:shoe_shop_app/widgets/product_card.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // Filters List
  final List<String> filters =const ['All', 'Addidas', 'Nike', 'Bata'];
  late  String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const border = OutlineInputBorder( 
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ), 
      borderRadius: BorderRadius.horizontal(left:  Radius.circular(50)),
    );
    
    return Column(
        children: [
      
          // Custom App Bar
          SafeArea(
            child: Row(
              children: [
                // Discription Text
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Shoe\nCollection", style: Theme.of(context).textTheme.titleLarge,),
                ), const SizedBox(width: 20,),
      
                // Search Field
                const Expanded(child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    border: border, enabledBorder: border,
                    focusedBorder: border,
                  ),
                )),
              ],
            ),
          ),

          // Filter Section
          SizedBox( height: 120, 
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      label: Text(filter, style: TextStyle(
                        color: selectedFilter == filter ?Colors.white70: Colors.black,
                      ),),
                      labelStyle: const TextStyle(fontSize: 16),
                      backgroundColor: selectedFilter == filter ? const Color.fromARGB(255, 236, 64, 122) : const Color.fromRGBO(245, 247, 249, 1),
                      side: const BorderSide(color:Color.fromRGBO(245, 247, 249, 1)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: size.width > 1080 
            ? GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.75), 
            itemBuilder: (context, index) {
              final product = products[index];
                return GestureDetector (
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return ProductDetailsPage(product: product);
                    }));
                  },
                  child: ProductCard(
                    title: product['title'] as String, 
                    price: product['price'] as double,
                    image: product['imageUrl'] as String, bgColor: index.isEven 
                      ? const Color.fromARGB(255, 253, 216, 234) 
                      : const Color.fromRGBO(245, 247, 249, 1))
                );
              }
            )
            
            : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector (
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return ProductDetailsPage(product: product);
                    }));
                  },
                  child: ProductCard(
                    title: product['title'] as String, 
                    price: product['price'] as double,
                    image: product['imageUrl'] as String, bgColor: index.isEven 
                      ? const Color.fromARGB(255, 253, 216, 234) 
                      : const Color.fromRGBO(245, 247, 249, 1))
                );
              },
            ),
          ),

        ],
      );
  }
}