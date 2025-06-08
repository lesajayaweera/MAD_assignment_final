import 'package:flutter/material.dart';
import 'package:my_app/Data/items.dart';
import 'package:my_app/screens/ProductsDetail.dart';

class featuredItem extends StatelessWidget {
  const featuredItem({super.key,required this.product});
 
  final Products product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(product: product)));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
                width: 300,
                height: 200,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                product.name,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: product.isNew ? Colors.redAccent : Colors.orangeAccent,
                ),
                child: Text(
                  product.isNew ? 'New' : 'Used',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
