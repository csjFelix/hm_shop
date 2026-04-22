import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HmMoreList extends StatefulWidget {
  const HmMoreList({super.key});

  @override
  State<HmMoreList> createState() => _HmMoreListState();
}

class _HmMoreListState extends State<HmMoreList> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      // 网格是两列
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.center,
          color: Colors.blue,
          child: Text("商品"),
        );
      },
    );
  }
}
