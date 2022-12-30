import '../widgets/category_item.dart';

import '../providers/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<Categories>(context);
    final categoriyItems = categories.items;
    return Container(
      width: double.infinity,
      height: 150,
      child: ListView.builder(
        itemCount: categoriyItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          value: categoriyItems[index],
          child: CategoryItem(),
        ),
      ),
    );
  }
}
