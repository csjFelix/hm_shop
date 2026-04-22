import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;

  const HmSlider({super.key, required this.bannerList});

  @override
  State<HmSlider> createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  Widget _getSlider() {
    // 在Flutter中获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of(context).size.width; 
    // 返回轮播图插件
    // 根据数据渲染不同的轮播选项
    return CarouselSlider(
      items: List.generate(widget.bannerList.length, (index) {
        return Image.network(widget.bannerList[index].imagUrl,fit: BoxFit.cover,width: screenWidth,);
      // fit: BoxFit.cover,width: screenWidth,
      }),
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,


      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // stack ->轮播图，搜索框，指示灯导航
    return Stack(children: [_getSlider()]);
    // return Container(
    //   height: 300,
    //   alignment: Alignment.center,
    //   color: Colors.blue,
    //   child: Text("轮播图",style: TextStyle(color: Colors.white,fontSize: 20 )),
    // );
  }
}
