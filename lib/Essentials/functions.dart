String formatPrice(double price) {
  String result = price.toStringAsFixed(2); 
  List<String> parts = result.split('.'); 
  String integerPart = parts[0];
  String decimalPart = parts[1];

  
  String formattedInteger = '';
  for (int i = 0; i < integerPart.length; i++) {
    int position = integerPart.length - i;
    formattedInteger = integerPart[position - 1] + formattedInteger;
    if (i % 3 == 2 && position > 1) {
      formattedInteger = ',' + formattedInteger;
    }
  }

  return '\$${formattedInteger}.${decimalPart}';
}
