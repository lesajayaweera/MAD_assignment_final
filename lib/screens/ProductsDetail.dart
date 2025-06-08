import 'package:flutter/material.dart';
import 'package:my_app/components/common/myappBar.dart';

class ProductDetails extends StatefulWidget {
  final int productId;

  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(title: 'Vehicle Name'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),

              child: Image.asset(
                'asset/image/car.jpg',
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vehicle Name',
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rs.1,800',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '4/5',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent.shade200,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.star, color: Colors.amberAccent.shade400),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'vsjnkwemv;lmevw;lmwe;lmwelmevwlmvwe;lmvw;lmvw;lmvw;lmw;vlm;lvm;wlmv;lmwv;lm;lwvm;lmwlmvwempwlm[wmmvsjnkwemv;lmevw;lmwe;lmwelmevwlmvwe;lmvw;lmvw;lmvw;lmw;vlm;lvm;wlmv;lmwv;lm;lwvm;lmwlmvwempwlm[wmmvsjnkwemv;lmevw;lmwe;lmwelmevwlmvwe;lmvw;lmvw;lmvw;lmw;vlm;lvm;wlmv;lmwv;lm;lwvm;lmwlmvwempwlm[wmmvsjnkwemv;lmevw;lmwe;lmwelmevwlmvwe;lmvw;lmvw;lmvw;lmw;vlm;lvm;wlmv;lmwv;lm;lwvm;lmwlmvwempwlm[wmmvsjnkwemv;lmevw;lmwe;lmwelmevwlmvwe;lmvw;lmvw;lmvw;lmw;vlm;lvm;wlmv;lmwv;lm;lwvm;lmwlmvwempwlm[wmm',
                    style: TextStyle(fontFamily: 'poppins'),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
