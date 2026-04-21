// 管理路由
import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Login/index.dart';
import 'package:hm_shop/pages/Main/index.dart';

// 返回App根级组件
Widget getRootWidget () {
  return MaterialApp(
    initialRoute: "/",
    routes: getRootRoutes (),
    
  );

}
// 返回该app的路由配置
Map<String, Widget Function(BuildContext)> getRootRoutes () {
  return {
    "/":(context) => MainPage(),
    "/login":(context) => LoginPage(),
      
    
  };

}