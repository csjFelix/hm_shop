import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HmCategory extends StatefulWidget {
  const HmCategory({super.key});

  @override
  State<HmCategory> createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            height: 100,
            width: 80,
            margin: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.blue,
            child: Text("分类$index",style: TextStyle(color: Colors.white,),
          ));
        },
        itemCount: 10,
      ),
    );
  }
}
