import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'colors.dart';
import 'model/product.dart';

class CategoryMenuPage extends StatelessWidget {
  final List<Category> _categories = Category.values;
  final Category currentCategory;
  final ValueChanged<Category> onCategoryTap;

  const CategoryMenuPage(
      {Key key, @required this.currentCategory, @required this.onCategoryTap})
      : assert(currentCategory != null),
        assert(onCategoryTap != null),
        super(key: key);

  Widget _buildCategory(BuildContext context, Category category) {
    
    final categoryString =
        category.toString().replaceAll('Category.', '').toUpperCase();
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onCategoryTap,
      child: category == currentCategory
          ? Column(
              children: <Widget>[
                SizedBox(height: 16.0),
                Text(
                  categoryString,
                  style: theme.textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 14.0),
                Container(
                  width: 70.0,
                  height: 2.0,
                  color: kShrinePink400,
                ),
              ],
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                categoryString,
                style: theme.textTheme.bodyText1
                    .copyWith(color: kShrineBrown900.withAlpha(153)),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding : EdgeInsets.all(40.0),
        color : kShrinePink100,
        child : ListView(
          children: _categories.map((e) => _buildCategory(context, e)).toList(),
        ),
      ),
    );
  }
}
