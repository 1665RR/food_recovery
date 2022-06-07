import 'package:flutter/material.dart';

class FoodSearchBox extends StatelessWidget {
  const FoodSearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search for food',
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
                contentPadding:
                const EdgeInsets.only(left: 20.0, bottom: 5.0, top: 12.0,),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: (){},
            ),
          ),
        ],
      ),
    );
  }
}
