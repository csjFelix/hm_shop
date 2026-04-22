import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HmHot extends StatefulWidget {
  const HmHot({super.key});

  @override
  State<HmHot> createState() => _HmHotState();
}

class _HmHotState extends State<HmHot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text("爆款", style: TextStyle(color: Colors.white)),
    );
  }
}