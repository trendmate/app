import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:trendmate/models/filter.dart';

class FiltersProvider with ChangeNotifier {
  Filter _filters = Filter(
      brands: {"Monte Carlo": true, "Nike": true, "Gucci": false},
      gender: {"Men": true, "Women": true},
      cats: {"t-shirt": true, "shoes": true, "jeans": false},
      sites: {"myntra": true, "amazon": true, "flipkart": false},
      priceEnd: 3000,
      priceStart: 0);

  Filter get filters {
    Filter curr = _filters;
    return curr;
  }
}
