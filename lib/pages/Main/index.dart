import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageStateState();
}

class _MainPageStateState extends State<MainPage> {
  // 定义数据，根据数据进行渲染4个导航
  // 一般应用程序的导航是不变的
  final List<Map<String, String>> _tableList = [
    {
      "icon": "lib/assets/ic_public_home_normal.png", // 正常显示的图标
      "active_icon": "lib/assets/ic_public_home_active.png", // 激活显示的图标
      "text": "首页",
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png", // 正常显示的图标
      "active_icon": "lib/assets/ic_public_pro_active.png", // 激活显示的图标
      "text": "分类",
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png", // 正常显示的图标
      "active_icon": "lib/assets/ic_public_cart_active.png", // 激活显示的图标
      "text": "购物车",
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png", // 正常显示的图标
      "active_icon": "lib/assets/ic_public_my_active.png", // 激活显示的图标
      "text": "我的",
    },

  ];
  // 导航栏当前点击的索引
  int _currentIndex = 0;
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tableList.length, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tableList[index]["icon"]!, width: 30, height: 30),// 正常显示图标
        activeIcon: Image.asset(_tableList[index]["active_icon"]!, width: 30, height: 30),// 激活图标
        label: _tableList[index]["text"]
      );
    });
  }

  List<Widget> _getStackChildren() {
    return [HomeView(),CategoryView(),CartView(),MineView()];
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: IndexedStack(
        index: _currentIndex,
        children: _getStackChildren(),
      )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 去掉导航栏切换动画
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          // index就是当前点击的索引
          _currentIndex = index;
          setState(() {
            
          });

          
        },
        items: _getTabBarWidget(),
        currentIndex: _currentIndex,
        ),
    );
  }
}
