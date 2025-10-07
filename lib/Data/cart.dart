import 'package:my_app/Classes/model/Orders.dart';


List<Vehicle> cart =[];

void AddtoCart(Vehicle product){
  if(!cart.contains(product)){
    cart.add(product);
  }
}
void RemoveProduct (Vehicle product){
  cart.remove(product);
}

double GetTotal(){
  double total = 0.0;
  for (var item in cart) {
    total += double.parse(item.price);
  }
  return total;
}