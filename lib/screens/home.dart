import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_app/Classes/model/Vehicles.dart';
import 'package:my_app/Classes/vehicle_service.dart';
import 'package:my_app/components/pages/Home/featuredItem.dart';
import 'package:my_app/components/pages/Home/product_container.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  late final Timer _timer;

  List<Vehicle> _vehicles = [];
  List<Vehicle> _filteredVehicles = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    _fetchVehicle();

    _timer = Timer.periodic(Duration(seconds: 6), (timer) {
      if (_scrollController.hasClients && _filteredVehicles.isNotEmpty) {
        double nextPosition = _scrollController.offset + 300;
        if (nextPosition >= _scrollController.position.maxScrollExtent) {
          _scrollController.animateTo(
            0,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            nextPosition,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      }
    });

    // Listen to search input changes
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _fetchVehicle() async {
    try {
      final response = await VehicleService.getVehicles();
      setState(() {
        _vehicles = response
            .map<Vehicle>((json) => Vehicle.fromJson(json))
            .toList();
        _filteredVehicles = _vehicles;
        print(_vehicles);
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching vehicles: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      if (_searchQuery.isEmpty) {
        _filteredVehicles = _vehicles;
      } else {
        _filteredVehicles = _vehicles.where((vehicle) {
          // Search by make, model, year, or any other relevant fields
          final make = vehicle.make?.toLowerCase() ?? '';
          final model = vehicle.model?.toLowerCase() ?? '';
          final year = vehicle.year?.toString() ?? '';
          
          
          return make.contains(_searchQuery) ||
                 model.contains(_searchQuery) ||
                 year.contains(_searchQuery);
                 
        }).toList();
      }
    });
  }

  List<Vehicle> _getLatestVehicles() {
    // Create a copy and sort by createdAt or year (assuming newer first)
    List<Vehicle> latestVehicles = List.from(_filteredVehicles);
    
    latestVehicles.sort((a, b) {
      // First try to sort by createdAt if available
      if (a.createdAt != null && b.createdAt != null) {
        return b.createdAt!.compareTo(a.createdAt!);
      }
      // Fallback to year if createdAt is not available
      if (a.year != null && b.year != null) {
        return b.year!.compareTo(a.year!);
      }
      return 0;
    });
    
    return latestVehicles;
  }

  // Pull-to-refresh handler
  Future<void> _handleRefresh() async {
    setState(() {
      _isLoading = true;
    });
    await _fetchVehicle();
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
      _filteredVehicles = _vehicles;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAll}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Color(0xFF1A1A1A),
              letterSpacing: -0.5,
            ),
          ),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'See All',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.blue.shade700,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSearching = _searchQuery.isNotEmpty;

    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSearching ? Icons.search_off : Icons.directions_car_outlined,
              size: 80,
              color: isDark ? Colors.grey.shade600 : Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              isSearching ? 'No Results Found' : 'No Cars Available',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isSearching
                  ? 'Try different keywords'
                  : 'Check back later for new listings',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: isSearching ? _clearSearch : _handleRefresh,
              icon: Icon(isSearching ? Icons.clear : Icons.refresh),
              label: Text(isSearching ? 'Clear Search' : 'Refresh'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: CircularProgressIndicator(color: Colors.blue.shade700),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final latestVehicles = _getLatestVehicles();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: Colors.blue.shade700,
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),

              // Search bar section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 12.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey.shade900 : Colors.white,
                          borderRadius: BorderRadius.circular(14.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                isDark ? 0.3 : 0.04,
                              ),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search for cars...',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: isDark
                                  ? Colors.grey.shade500
                                  : Colors.grey.shade400,
                              fontWeight: FontWeight.w400,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: isDark
                                  ? Colors.grey.shade500
                                  : Colors.grey.shade600,
                              size: 22,
                            ),
                            suffixIcon: _searchQuery.isNotEmpty
                                ? IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      color: isDark
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade600,
                                      size: 20,
                                    ),
                                    onPressed: _clearSearch,
                                  )
                                : null,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey.shade900 : Colors.white,
                        borderRadius: BorderRadius.circular(14.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              isDark ? 0.3 : 0.04,
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.tune,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                        ),
                        onPressed: () {
                          // Handle filter action
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Show loading, empty state, or content
              _isLoading
                  ? _buildLoadingState()
                  : _filteredVehicles.isEmpty
                  ? _buildEmptyState()
                  : Column(
                      children: [
                        // Featured Cars section
                        _buildSectionHeader('Featured Cars'),
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                            itemCount: _filteredVehicles.length,
                            physics: const BouncingScrollPhysics(),
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                            ),
                            itemBuilder: (context, index) {
                              final car = _filteredVehicles[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: featuredItem(product: car),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Latest Cars section (sorted by date/year)
                        _buildSectionHeader(
                          'Latest Cars',
                          onSeeAll: () {
                            // Handle see all action
                          },
                        ),
                        SizedBox(
                          height: 400,
                          child: ListView.builder(
                            itemCount: latestVehicles.length,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                            ),
                            itemBuilder: (context, index) {
                              final item = latestVehicles[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: ProductContainer(product: item),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Popular Cars section
                        _buildSectionHeader(
                          'Popular Cars',
                          onSeeAll: () {
                            // Handle see all action
                          },
                        ),
                        SizedBox(
                          height: 400,
                          child: ListView.builder(
                            itemCount: _filteredVehicles.length,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                            ),
                            itemBuilder: (context, index) {
                              final items = _filteredVehicles[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: ProductContainer(product: items),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}