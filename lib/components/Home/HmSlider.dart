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
  CarouselSliderController _controller =
      CarouselSliderController(); //控制轮播图跳转的控制器
  int _currentIndex = 0;

  Widget _getSlider() {
    // 在Flutter中获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of(context).size.width;
    // 返回轮播图插件
    // 根据数据渲染不同的轮播选项
    return CarouselSlider(
      carouselController: _controller, // 绑定controller对象
      items: List.generate(widget.bannerList.length, (index) {
        return Image.network(
          widget.bannerList[index].imagUrl,
          fit: BoxFit.cover,
          width: screenWidth,
        );
        // fit: BoxFit.cover,width: screenWidth,
      }),
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        onPageChanged: (int index, reason) {
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }

  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.6),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            "搜索...",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  // 返回指示灯导航部件
  Widget _getDot() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: SizedBox(
        height: 40,
        width: double.infinity, // 宽不用写了，定位已经左右都是0撑满了
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.bannerList.length, (int index) {
            return GestureDetector(
              onTap: () {
                _controller.jumpToPage(index);
                // _currentIndex = index;
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 6,
                width: index == _currentIndex ? 40 : 20,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == _currentIndex
                      ? Colors.white
                      : Color.fromRGBO(0, 0, 0, 0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // stack ->轮播图，搜索框，指示灯导航
    return Stack(children: [_getSlider(), _getSearch(), _getDot()]);
    // return Container(
    //   height: 300,
    //   alignment: Alignment.center,
    //   color: Colors.blue,
    //   child: Text("轮播图",style: TextStyle(color: Colors.white,fontSize: 20 )),
    // );
  }
}
