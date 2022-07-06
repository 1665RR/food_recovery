import 'package:flutter/material.dart';
import 'package:food_app/api/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/category_model.dart';



class CategoryDetails extends StatefulWidget {
  final Category category;
  const CategoryDetails({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {


  @override
  void initState(){
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
      },
      child:Container(
        width: 88,
        margin: const EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Stack(
          children: [
            Positioned(
              top:10,
              left: 15,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("http://10.0.2.2:8080/${widget.category.image.replaceAll(r'\', r'/')}"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  widget.category.name,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}