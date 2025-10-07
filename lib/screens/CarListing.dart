
import 'package:flutter/material.dart';
import 'package:my_app/Classes/model/Vehicles.dart';
import 'package:my_app/Classes/vehicle_service.dart';
import 'package:my_app/components/pages/Home/product_container.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Vehicle> _vehicles = [];
  List<Vehicle> _filteredVehicles = [];
  String selectedBrand = 'All';
  String sortBy = 'newest';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchVehicle();
  }

  Future<void> _fetchVehicle() async {
    try {
      setState(() {
        _isLoading = true;
      });
      
      final response = await VehicleService.getVehicles();
      setState(() {
        _vehicles = response.map<Vehicle>((json) => Vehicle.fromJson(json)).toList();
        _applyFilters();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching vehicles: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    List<Vehicle> filtered = List.from(_vehicles);

    // Apply brand filter
    if (selectedBrand != 'All') {
      filtered = filtered.where((vehicle) {
        return vehicle.make.toLowerCase() == selectedBrand.toLowerCase();
      }).toList();
    }

    // Apply sorting
    switch (sortBy) {
      case 'newest':
        filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'price_low':
        filtered.sort((a, b) {
          double priceA = double.tryParse(a.price) ?? 0;
          double priceB = double.tryParse(b.price) ?? 0;
          return priceA.compareTo(priceB);
        });
        break;
      case 'price_high':
        filtered.sort((a, b) {
          double priceA = double.tryParse(a.price) ?? 0;
          double priceB = double.tryParse(b.price) ?? 0;
          return priceB.compareTo(priceA);
        });
        break;
      case 'name':
        filtered.sort((a, b) => a.make.compareTo(b.make));
        break;
      case 'year_new':
        filtered.sort((a, b) => b.year.compareTo(a.year));
        break;
      case 'year_old':
        filtered.sort((a, b) => a.year.compareTo(b.year));
        break;
    }

    setState(() {
      _filteredVehicles = filtered;
    });
  }

  // Get unique brands from vehicles
  List<Map<String, String>> _getBrands() {
    Set<String> uniqueBrands = _vehicles.map((v) => v.make).toSet();
    
    List<Map<String, String>> brands = [
      {'name': 'All', 'image': ''},
    ];

    // Add brands from actual vehicle data
    for (String brand in uniqueBrands) {
      brands.add({
        'name': brand,
        'image': _getBrandImage(brand),
      });
    }

    return brands;
  }

  // Helper to get brand logo (you can customize this)
  String _getBrandImage(String brand) {
    final brandImages = {
      'BMW': 'asset/image/bmw_logo.png',
      'Benz': 'asset/image/benz_logo.png',
      'Rolls Royce': 'asset/image/royce_logo.png',
      'Lamborghini': 'asset/image/lamborghini_logo.png',
      'Mclern': 'asset/image/mclaren_logo.png',
      'Audi': 'asset/image/audi_logo.png',
    };
    return brandImages[brand] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final orientation = MediaQuery.of(context).orientation;
    final brands = _getBrands();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Header Section
          Container(
            color: isDark ? Colors.grey.shade900 : Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'All Cars',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Color(0xFF1A1A1A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.blue.shade900.withOpacity(0.3) : Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${_filteredVehicles.length} cars',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.blue.shade300 : Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Brand Filter Chips
                SizedBox(
                  height: 44,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: brands.length,
                    itemBuilder: (context, index) {
                      final brand = brands[index];
                      final isSelected = selectedBrand == brand['name'];
                      
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: FilterChip(
                          selected: isSelected,
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (brand['image']!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Image.asset(
                                    brand['image']!,
                                    height: 20,
                                    width: 20,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ),
                              Text(
                                brand['name']!,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? Colors.white
                                      : (isDark ? Colors.grey.shade300 : Colors.grey.shade700),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: isDark ? Colors.grey.shade800 : Colors.white,
                          selectedColor: Colors.blue.shade600,
                          checkmarkColor: Colors.white,
                          side: BorderSide(
                            color: isSelected
                                ? Colors.blue.shade600
                                : (isDark ? Colors.grey.shade600 : Colors.grey.shade300),
                            width: 1.5,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          onSelected: (selected) {
                            setState(() {
                              selectedBrand = brand['name']!;
                              _applyFilters();
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Sort and Filter Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: sortBy,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                            dropdownColor: isDark ? Colors.grey.shade800 : Colors.white,
                            items: const [
                              DropdownMenuItem(
                                value: 'newest',
                                child: Text('Newest First'),
                              ),
                              DropdownMenuItem(
                                value: 'price_low',
                                child: Text('Price: Low to High'),
                              ),
                              DropdownMenuItem(
                                value: 'price_high',
                                child: Text('Price: High to Low'),
                              ),
                              DropdownMenuItem(
                                value: 'name',
                                child: Text('Name: A to Z'),
                              ),
                              DropdownMenuItem(
                                value: 'year_new',
                                child: Text('Year: Newest'),
                              ),
                              DropdownMenuItem(
                                value: 'year_old',
                                child: Text('Year: Oldest'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                sortBy = value!;
                                _applyFilters();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey.shade800 : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.tune,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                        ),
                        onPressed: () {
                          _showAdvancedFilters();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Grid Section
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue.shade600,
                    ),
                  )
                : _filteredVehicles.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 80,
                              color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No vehicles found',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try adjusting your filters',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          double screenWidth = constraints.maxWidth;

                          int crossAxisCount = orientation == Orientation.landscape
                              ? (screenWidth ~/ 280).clamp(2, 6)
                              : (screenWidth ~/ 320).clamp(1, 4);

                          double aspectRatio =
                              orientation == Orientation.landscape ? 0.85 : 0.95;

                          return GridView.builder(
                            itemCount: _filteredVehicles.length,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(20),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              childAspectRatio: aspectRatio,
                            ),
                            itemBuilder: (context, index) {
                              final item = _filteredVehicles[index];
                              return ProductContainer(product: item);
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  void _showAdvancedFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AdvancedFilterSheet(
        vehicles: _vehicles,
        onApply: (filters) {
          setState(() {
            // Apply advanced filters here
            _applyFilters();
          });
        },
      ),
    );
  }
}

// Advanced Filter Bottom Sheet
class AdvancedFilterSheet extends StatefulWidget {
  final List<Vehicle> vehicles;
  final Function(Map<String, dynamic>) onApply;

  const AdvancedFilterSheet({
    Key? key,
    required this.vehicles,
    required this.onApply,
  }) : super(key: key);

  @override
  State<AdvancedFilterSheet> createState() => _AdvancedFilterSheetState();
}

class _AdvancedFilterSheetState extends State<AdvancedFilterSheet> {
  RangeValues _priceRange = const RangeValues(0, 2000000);
  RangeValues _yearRange = const RangeValues(2015, 2025);
  String? _selectedFuelType;
  String? _selectedTransmission;
  String? _selectedCondition;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Advanced Filters',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _priceRange = const RangeValues(0, 2000000);
                    _yearRange = const RangeValues(2015, 2025);
                    _selectedFuelType = null;
                    _selectedTransmission = null;
                    _selectedCondition = null;
                  });
                },
                child: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Price Range
          Text(
            'Price Range',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 2000000,
            divisions: 20,
            labels: RangeLabels(
              '\$${_priceRange.start.round()}',
              '\$${_priceRange.end.round()}',
            ),
            onChanged: (values) {
              setState(() {
                _priceRange = values;
              });
            },
          ),
          
          const SizedBox(height: 16),
          
          // Year Range
          Text(
            'Year Range',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          RangeSlider(
            values: _yearRange,
            min: 2010,
            max: 2025,
            divisions: 15,
            labels: RangeLabels(
              _yearRange.start.round().toString(),
              _yearRange.end.round().toString(),
            ),
            onChanged: (values) {
              setState(() {
                _yearRange = values;
              });
            },
          ),
          
          const SizedBox(height: 24),
          
          // Apply Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onApply({
                  'priceRange': _priceRange,
                  'yearRange': _yearRange,
                  'fuelType': _selectedFuelType,
                  'transmission': _selectedTransmission,
                  'condition': _selectedCondition,
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Apply Filters',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}