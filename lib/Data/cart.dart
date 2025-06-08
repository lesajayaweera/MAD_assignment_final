import 'package:my_app/Data/items.dart';

List<Products> cart =[];

void AddtoCart(Products product){
  if(!cart.contains(product)){
    cart.add(product);
  }
}
void RemoveProduct (Products product){
  cart.remove(product);
}