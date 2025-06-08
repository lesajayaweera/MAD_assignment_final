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

double GetTotal(){
  double total = 0.0;
  for (var item in cart) {
    total += item.price;
  }
  return total;
}