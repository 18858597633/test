import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:convert';
import 'package:dio/dio.dart ' as Dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nbut_take_out/AJ-Captcha/loadingBlockPuzzle.dart';
import 'package:nbut_take_out/input.dart';
import 'package:nbut_take_out/login.dart';
import 'package:nbut_take_out/icon.dart';
import 'package:nbut_take_out/R.dart';
import 'package:nbut_take_out/anim_bg_demo_page.dart';
import 'package:nbut_take_out/test.dart';
import 'package:get/get.dart';
import 'package:nbut_take_out/listViexgetx.dart';
import 'package:nbut_take_out/order.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:nbut_take_out/center.dart';
import 'package:flutter/material.dart';

class Toolbar extends StatefulWidget {
  Toolbar({Key? key}) : super(key: key);

  @override
  State<Toolbar> createState() => _ToolbarState();
}

class _ToolbarState extends State<Toolbar> {
  int currentIndex = 0; // 当前选中项索引
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(), // 禁止手势滑动（如果需要手势滑动，可以去掉）
        children: [
          order() ,
          order() ,
          order() ,
          order() ,
          CenterPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromRGBO(43, 76, 126, 1),
        unselectedItemColor: Color.fromRGBO(43, 76, 126, .5),
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index; // 更新选中的索引
          });
          // 使用 PageController 的 animateToPage 方法实现平滑动画
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300), // 动画时长
            curve: Curves.easeInOut,               // 动画曲线
          );
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: '点餐'),
          BottomNavigationBarItem(icon: Icon(Icons.article_rounded), label: '订单'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: '购物车'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}


