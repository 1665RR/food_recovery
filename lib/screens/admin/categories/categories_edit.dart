import 'package:flutter/material.dart';

import '../../../models/category_model.dart';


class CategoryEdit extends StatefulWidget {
  // inal Category category;
  const CategoryEdit({
    Key? key,
    //required this.category,
  }) : super(key: key);

  static const String routeName = '/categories-edit';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => CategoryEdit(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<CategoryEdit> createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {
 // late List<User>? _shops = [];

  @override
  void initState(){
    super.initState();
  }

  Future _editCategories() async{

  }

  @override
  Widget build(BuildContext context) {

    return Container(
        width: 88,
        margin: const EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
    );
  }
}