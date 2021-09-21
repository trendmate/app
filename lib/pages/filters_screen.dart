import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters-screen';

  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var selectedRange = RangeValues(500, 2000);

  final List<Pair> _categories = <Pair>[
    Pair('t-shirts', false),
    Pair('jeans', false),
    Pair('shoes', false),
  ];

  final List<Pair> _websites = <Pair>[
    Pair('myntra', false),
    Pair('amazon', false),
    Pair('flipkart', false),
  ];

  final List<Pair> _brands = <Pair>[
    Pair('nike', false),
    Pair('monte-carlo', false),
    Pair('gucci', false),
  ];

  final List<Pair> _gender = <Pair>[
    Pair('men', false),
    Pair('women', false),
  ];

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    child: Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(8),
                        children: _categories
                            .map((Pair category) => CheckboxListTile(
                                title: Text(category.title),
                                value: category.isChecked,
                                onChanged: (bool? val) {
                                  if (val != null) {
                                    setState(() {
                                      category.isChecked = val;
                                    });
                                  }
                                }))
                            .toList(),
                      ),
                    )),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Websites",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    child: Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(8),
                        children: _websites
                            .map((Pair website) => CheckboxListTile(
                                title: Text(website.title),
                                value: website.isChecked,
                                onChanged: (bool? val) {
                                  if (val != null) {
                                    setState(() {
                                      website.isChecked = val;
                                    });
                                  }
                                }))
                            .toList(),
                      ),
                    )),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Brands",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    child: Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(8),
                        children: _brands
                            .map((Pair brand) => CheckboxListTile(
                                title: Text(brand.title),
                                value: brand.isChecked,
                                onChanged: (bool? val) {
                                  if (val != null) {
                                    setState(() {
                                      brand.isChecked = val;
                                    });
                                  }
                                }))
                            .toList(),
                      ),
                    )),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Gender",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    child: Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(8),
                        children: _gender
                            .map((Pair website) => CheckboxListTile(
                                title: Text(website.title),
                                value: website.isChecked,
                                onChanged: (bool? val) {
                                  if (val != null) {
                                    setState(() {
                                      website.isChecked = val;
                                    });
                                  }
                                }))
                            .toList(),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}

class Pair {
  String title;
  bool isChecked;

  Pair(this.title, this.isChecked);
}
