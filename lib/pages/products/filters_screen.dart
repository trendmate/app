import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendmate/models/ecom/filter.dart';

import 'package:trendmate/providers/filters_provider.dart';
import 'package:trendmate/providers/products_provider.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters-screen';

  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var selectedRange = RangeValues(500, 2000);

  @override
  void initState() {
    final filters =
        Provider.of<ProductsProvider>(context, listen: false).filters;
    selectedRange = RangeValues(filters.priceStart, filters.priceEnd);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // provider.filter.cats.map((e) => _categories
    //         .where((element) => element.title.compareTo(e) == 0)
    //         .forEach((element) {
    //       element.isChecked = true;
    //     }));
    // provider.filter.brands.map((e) => _brands
    //         .where((element) => element.title.compareTo(e) == 0)
    //         .forEach((element) {
    //       element.isChecked = true;
    //     }));
    // selectedRange =
    //     RangeValues(provider.filter.priceStart, provider.filter.priceEnd);

    return Consumer<ProductsProvider>(builder: (context, value, child) {
      final filters = value.filters;

      final Map<String, bool> _categories = filters.cats;
      final Map<String, bool> _websites = filters.sites;
      final Map<String, bool> _brands = filters.brands;
      final Map<String, bool> _gender = filters.gender;

      return Scaffold(
          appBar: AppBar(
              title: Text(
                "Filters",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.white30,
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: true,
              actions: [
                TextButton(
                    onPressed: () {
                      value.setFilter(Filter(
                          brands: _brands,
                          cats: _categories,
                          sites: _websites,
                          gender: _gender,
                          priceStart: selectedRange.start,
                          priceEnd: selectedRange.end));
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Apply",
                      style: TextStyle(color: Colors.blue[600]),
                    ))
              ]),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Price Range",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 1),
                              blurRadius: 2),
                        ]),
                    child: RangeSlider(
                      values: selectedRange,
                      onChanged: ((RangeValues newRange) {
                        setState(() {
                          selectedRange = newRange;
                        });
                      }),
                      min: 0,
                      max: 5000,
                      divisions: 5,
                      labels: RangeLabels(
                          '${selectedRange.start.round().toString()}',
                          '${selectedRange.end.round().toString()}'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Categories",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 1),
                                blurRadius: 2),
                          ]),
                      child: ListView.builder(
                          itemCount: _categories.length,
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (BuildContext context, int idx) {
                            String key = _categories.keys.elementAt(idx);

                            return CheckboxListTile(
                                title: Text(key),
                                value: _categories[key],
                                onChanged: (bool? val) {
                                  if (val != null) {
                                    setState(() {
                                      _categories[key] = val;
                                    });
                                  }
                                });
                          })),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Websites",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 1),
                              blurRadius: 2),
                        ]),
                    child: ListView.builder(
                        itemCount: _websites.length,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (BuildContext context, int idx) {
                          String key = _websites.keys.elementAt(idx);

                          return CheckboxListTile(
                              title: Text(key),
                              value: _websites[key],
                              onChanged: (bool? val) {
                                if (val != null) {
                                  setState(() {
                                    _websites[key] = val;
                                  });
                                }
                              });
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Brands",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 1),
                              blurRadius: 2),
                        ]),
                    child: ListView.builder(
                        itemCount: _brands.length,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (BuildContext context, int idx) {
                          String key = _brands.keys.elementAt(idx);

                          return CheckboxListTile(
                              title: Text(key),
                              value: _brands[key],
                              onChanged: (bool? val) {
                                if (val != null) {
                                  setState(() {
                                    _brands[key] = val;
                                  });
                                }
                              });
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Gender",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 1),
                              blurRadius: 2),
                        ]),
                    child: ListView.builder(
                        itemCount: _gender.length,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (BuildContext context, int idx) {
                          String key = _gender.keys.elementAt(idx);

                          return CheckboxListTile(
                              title: Text(key),
                              value: _gender[key],
                              onChanged: (bool? val) {
                                if (val != null) {
                                  setState(() {
                                    _gender[key] = val;
                                  });
                                }
                              });
                        }),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}

class Pair {
  String title;
  bool isChecked;

  Pair(this.title, this.isChecked);
}
