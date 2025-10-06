// import 'package:flutter/material.dart';
// import 'package:my_app/Classes/orderService.dart';
// import 'package:my_app/Data/notifications.dart';
// import 'package:my_app/Essentials/functions.dart';
// import 'package:my_app/Classes/model/Orders.dart';
// import 'package:my_app/screens/OrderSucess.dart';

// class BillingInfoScreen extends StatefulWidget {
//   final List<Order> orders;
//   final double total;

//   const BillingInfoScreen({
//     super.key,
//     required this.orders,
//     required this.total,
//   });

//   @override
//   State<BillingInfoScreen> createState() => _BillingInfoScreenState();
// }

// class _BillingInfoScreenState extends State<BillingInfoScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _addressController = TextEditingController();
//   final _cityController = TextEditingController();
//   final _countryController = TextEditingController();
//   final _zipcodeController = TextEditingController();
//   final _apartmentController = TextEditingController();
//   bool _isProcessing = false;

//   @override
//   void dispose() {
//     _addressController.dispose();
//     _cityController.dispose();
//     _countryController.dispose();
//     _zipcodeController.dispose();
//     _apartmentController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleCheckout() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     setState(() {
//       _isProcessing = true;
//     });

//     try {
//       final billingInfo = {
//         'address': _addressController.text.trim(),
//         'city': _cityController.text.trim(),
//         'country': _countryController.text.trim(),
//         'zipcode': _zipcodeController.text.trim(),
//         'apartment': _apartmentController.text.trim(),
//       };

//       await OrderService.checkout(billingInfo);

//       // Add notifications
//       notifications.add(
//         NotificationItem(
//           title: 'Payment Successful',
//           subtitle: 'Your payment of ${formatPrice(widget.total)} was completed.',
//           icon: Icons.check_circle,
//           iconColor: Colors.green,
//           date: DateTime.now().toString().split(' ')[0],
//         ),
//       );

//       notifications.add(
//         NotificationItem(
//           title: 'Order Confirmed',
//           subtitle: '${widget.orders.length} items ordered successfully.',
//           icon: Icons.shopping_bag,
//           iconColor: Colors.orangeAccent,
//           date: DateTime.now().toString().split(' ')[0],
//         ),
//       );

//       if (mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OrderCompletedPage(
//               orders: widget.orders,
//               total: widget.total,
//             ),
//           ),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Payment failed: $e'),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 3),
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isProcessing = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Billing Information'),
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Enter Billing Details',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Please provide your billing address information',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 32),
//                     _buildTextField(
//                       controller: _addressController,
//                       label: 'Street Address',
//                       hint: '123 Main Street',
//                       icon: Icons.home_outlined,
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please enter your address';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     _buildTextField(
//                       controller: _apartmentController,
//                       label: 'Apartment/Suite (Optional)',
//                       hint: 'Apt 4B',
//                       icon: Icons.apartment_outlined,
//                     ),
//                     const SizedBox(height: 16),
//                     _buildTextField(
//                       controller: _cityController,
//                       label: 'City',
//                       hint: 'New York',
//                       icon: Icons.location_city_outlined,
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please enter your city';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: _buildTextField(
//                             controller: _countryController,
//                             label: 'Country',
//                             hint: 'USA',
//                             icon: Icons.public_outlined,
//                             validator: (value) {
//                               if (value == null || value.trim().isEmpty) {
//                                 return 'Required';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: _buildTextField(
//                             controller: _zipcodeController,
//                             label: 'Zip Code',
//                             hint: '10001',
//                             icon: Icons.pin_outlined,
//                             keyboardType: TextInputType.number,
//                             validator: (value) {
//                               if (value == null || value.trim().isEmpty) {
//                                 return 'Required';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 32),
//                     _buildOrderSummaryCard(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           _buildCheckoutButton(),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     required IconData icon,
//     String? Function(String?)? validator,
//     TextInputType? keyboardType,
//   }) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         hintText: hint,
//         prefixIcon: Icon(icon),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.blue, width: 2),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.red),
//         ),
//         filled: true,
//         fillColor: Colors.grey[50],
//       ),
//       keyboardType: keyboardType,
//       validator: validator,
//     );
//   }

//   Widget _buildOrderSummaryCard() {
//     final totalWithTax = widget.total + (widget.total * 0.09);
    
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Order Summary',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             _buildSummaryRow('Items', '${widget.orders.length}'),
//             const SizedBox(height: 8),
//             _buildSummaryRow('Subtotal', formatPrice(widget.total)),
//             const SizedBox(height: 8),
//             _buildSummaryRow('Tax (9%)', formatPrice(widget.total * 0.09)),
//             const Divider(height: 24, thickness: 1.5),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Total Amount',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   formatPrice(totalWithTax),
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSummaryRow(String label, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey[700],
//           ),
//         ),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCheckoutButton() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: ElevatedButton(
//           onPressed: _isProcessing ? null : _handleCheckout,
//           style: ElevatedButton.styleFrom(
//             minimumSize: const Size(double.infinity, 56),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             elevation: 0,
//           ),
//           child: _isProcessing
//               ? const SizedBox(
//                   height: 24,
//                   width: 24,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                   ),
//                 )
//               : const Text(
//                   'Complete Payment',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:my_app/Classes/orderService.dart';
import 'package:my_app/Data/notifications.dart';
import 'package:my_app/Essentials/functions.dart';
import 'package:my_app/Classes/model/Orders.dart';
import 'package:my_app/screens/OrderSucess.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class BillingInfoScreen extends StatefulWidget {
  final List<Order> orders;
  final double total;

  const BillingInfoScreen({
    super.key,
    required this.orders,
    required this.total,
  });

  @override
  State<BillingInfoScreen> createState() => _BillingInfoScreenState();
}

class _BillingInfoScreenState extends State<BillingInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final _apartmentController = TextEditingController();
  bool _isProcessing = false;
  bool _isFetchingLocation = false;

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _zipcodeController.dispose();
    _apartmentController.dispose();
    super.dispose();
  }

  Future<void> _fetchLocationDetails() async {
    setState(() {
      _isFetchingLocation = true;
    });

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled. Please enable them.');
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        setState(() {
          // Fill the form fields
          _addressController.text = 
              '${place.street ?? ''}'.trim();
          // Try multiple fields for city
          _cityController.text = place.locality ?? 
                                 place.subAdministrativeArea ?? 
                                 place.administrativeArea ?? '';
          _countryController.text = place.country ?? '';
          _zipcodeController.text = place.postalCode ?? '';
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location details fetched successfully!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to get location: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      setState(() {
        _isFetchingLocation = false;
      });
    }
  }

  Future<void> _handleCheckout() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final billingInfo = {
        'address': _addressController.text.trim(),
        'city': _cityController.text.trim(),
        'country': _countryController.text.trim(),
        'zipcode': _zipcodeController.text.trim(),
        'apartment': _apartmentController.text.trim(),
      };

      await OrderService.checkout(billingInfo);

      // Add notifications
      notifications.add(
        NotificationItem(
          title: 'Payment Successful',
          subtitle: 'Your payment of ${formatPrice(widget.total)} was completed.',
          icon: Icons.check_circle,
          iconColor: Colors.green,
          date: DateTime.now().toString().split(' ')[0],
        ),
      );

      notifications.add(
        NotificationItem(
          title: 'Order Confirmed',
          subtitle: '${widget.orders.length} items ordered successfully.',
          icon: Icons.shopping_bag,
          iconColor: Colors.orangeAccent,
          date: DateTime.now().toString().split(' ')[0],
        ),
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OrderCompletedPage(
              orders: widget.orders,
              total: widget.total,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment failed: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing Information'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter Billing Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please provide your billing address information',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Location Button
                    OutlinedButton.icon(
                      onPressed: _isFetchingLocation ? null : _fetchLocationDetails,
                      icon: _isFetchingLocation
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.my_location),
                      label: Text(_isFetchingLocation
                          ? 'Fetching Location...'
                          : 'Use My Current Location'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildTextField(
                      controller: _addressController,
                      label: 'Street Address',
                      hint: '123 Main Street',
                      icon: Icons.home_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _apartmentController,
                      label: 'Apartment/Suite (Optional)',
                      hint: 'Apt 4B',
                      icon: Icons.apartment_outlined,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _cityController,
                      label: 'City',
                      hint: 'New York',
                      icon: Icons.location_city_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildTextField(
                            controller: _countryController,
                            label: 'Country',
                            hint: 'USA',
                            icon: Icons.public_outlined,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            controller: _zipcodeController,
                            label: 'Zip Code',
                            hint: '10001',
                            icon: Icons.pin_outlined,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildOrderSummaryCard(),
                  ],
                ),
              ),
            ),
          ),
          _buildCheckoutButton(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildOrderSummaryCard() {
    final totalWithTax = widget.total + (widget.total * 0.09);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Items', '${widget.orders.length}'),
            const SizedBox(height: 8),
            _buildSummaryRow('Subtotal', formatPrice(widget.total)),
            const SizedBox(height: 8),
            _buildSummaryRow('Tax (9%)', formatPrice(widget.total * 0.09)),
            const Divider(height: 24, thickness: 1.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  formatPrice(totalWithTax),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: _isProcessing ? null : _handleCheckout,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: _isProcessing
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text(
                  'Complete Payment',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}