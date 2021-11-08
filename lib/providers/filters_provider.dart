// import 'package:flutter/cupertino.dart';

// import 'package:flutter/material.dart';

// import 'package:trendmate/models/ecom/filter.dart';
// import 'package:trendmate/services/firebase_methods.dart';

// class FiltersProvider with ChangeNotifier {
//   static final FiltersProvider instance = FiltersProvider._internal();
//   FiltersProvider._internal() {
//     _init();
//   }
//   factory FiltersProvider() {
//     return instance;
//   }
//   bool initilised = false;

//   Filter _filters = Filter(brands: {
//     // "Monte Carlo": true, "Nike": true, "Gucci": false
//   }, gender: {
//     "Men": true,
//     "Women": true
//   }, cats: {
//     // "t-shirt": true,
//     // "shoes": true,
//     // "jeans": false
//   }, sites: {
//     "myntra": true,
//     "amazon": true,
//     "flipkart": false
//   }, priceEnd: 3000, priceStart: 0);

//   Filter get filters => _filters;

//   Future _init() async {
//     if (!initilised) {
//       List<String> _brands = await FirebaseMethods.instance.getBrands();
//       _filters.brands =
//           Map.fromIterable(_brands, key: (e) => e, value: (e) => true);
//       initilised = true;
//       notifyListeners();
//     }
//   }
// }
