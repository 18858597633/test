import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
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

class Addresspage extends StatefulWidget {
  const Addresspage({super.key});

  @override
  State<Addresspage> createState() => _AddresspageState();
}

class _AddresspageState extends State<Addresspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //toolbarHeight: 3.0,
            title: Text(
              "地址管理",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            actions: [
              GestureDetector(
                  child: Padding(
                padding: EdgeInsets.only(top: 22),
                child: Text(
                  "新增地址",
                  style: TextStyle(color: Colors.black),
                ),
              ))
            ]),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("当前地址"),
                GestureDetector(
                  child: Row(children: [Icon(Icons.star), Text("进行定位")]),
                )
              ],
            ),
            StickyHeader(
              header: Row(children: [Container(color: Colors.white,child: Text("我的地址"),)]),
              content: Column(
                children: List.generate(22, (index) {
                  return Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Color.fromARGB(121, 189, 177, 177)))),
                    child: Row(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text("浙江省 宁波市 海曙区 西门街道",style: TextStyle(fontSize: 13,color: Color.fromARGB(255, 157, 156, 156)),),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3),child: Text("宁波工程学院",style: TextStyle(fontSize: 17)),
                            ),
                            Text("周先生 15068583314",style: TextStyle(fontSize: 14)),
                          ]),
                        ),
                        Flexible(flex: 1, child: Text("data"))
                      ],
                    ),
                  );
                }),
              ),
            )
          ]),
        ));
    //child: _outsideView(textView, initProvince, initCity, initTown),
  }
}
