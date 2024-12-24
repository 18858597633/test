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
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:nbut_take_out/centerList.dart';
class CenterPage extends StatefulWidget {
  const CenterPage({super.key});

  @override
  State<CenterPage> createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              //height: 20,
              color: Color.fromARGB(255, 33, 187, 243),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.star),
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
              color: const Color.fromARGB(255, 33, 187, 243),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 35.0, // 半径
                    backgroundImage: NetworkImage(
                        'https://zhoun-jun-jie-1.oss-cn-hangzhou.aliyuncs.com/nbgc2.jpg?x-oss-process=style/test'),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Expanded(
                      child: Text(
                    "userName",
                    style: TextStyle(fontSize: 22),
                  )),
                  Icon(
                    Icons.chevron_right,
                    size: 33,
                  ),
                ],
              ),
            ),
            onTap: () => {print("object")},
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                 Centerlist(leftIcon: Icons.star, str: "地址管理", ontap: (){print("1");},),
                 Centerlist(leftIcon: Icons.star, str: "钱包与积分", ontap: ()  {print("钱包与积分");},),
                 Centerlist(leftIcon: Icons.star, str: "优惠券", ontap: ()  {print("2");},),
                 Centerlist(leftIcon: Icons.star, str: "问题反馈", ontap: ()  {print("3");},),
                 Centerlist(leftIcon: Icons.star, str: "收藏", ontap: ()  {print("4");},),
                ],
              ))
        ],
      ),
    ));
  }
}
