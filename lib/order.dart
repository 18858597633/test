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

class order extends StatefulWidget {
  const order({super.key});

  @override
  State<order> createState() => _orderState();
}

class _orderState extends State<order> with orders {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ExtendedNestedScrollView(
          pinnedHeaderSliverHeightBuilder: () {
            return kToolbarHeight + 20; // 设置固定的 AppBar 高度，让菜品分类可以准确吸附
          },
          onlyOneScrollInBody: true, //阻止同步滚动
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  expandedHeight: 170,
                  pinned: true,
                  floating: false,
                  title: Text(
                    "选择套餐与菜品",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: const Color.fromARGB(255, 78, 185, 227),
                  flexibleSpace: FlexibleSpaceBar(
                      background: SafeArea(
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 56),
                          //设置背景图片
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: NetworkImage(
                                  'https://zhoun-jun-jie-1.oss-cn-hangzhou.aliyuncs.com/nbgc2.jpg?x-oss-process=style/test',
                                ),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Card(
                            color: const Color.fromARGB(188, 255, 255, 255),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: EdgeInsets.only(
                                left: 10.0, top: 60.0, right: 10.0, bottom: 7),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: Image(
                                        image: NetworkImage(
                                            'https://zhoun-jun-jie-1.oss-cn-hangzhou.aliyuncs.com/nbgc.png?x-oss-process=style/test')),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        Container(
                                            child: Align(
                                          //alignment: Alignment.topCenter,
                                          child: Row(children: [
                                            const Text(
                                              "宁工食堂",
                                              style: TextStyle(fontSize: 20),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(11),
                                                color: const Color.fromARGB(
                                                    115, 104, 103, 103),
                                              ),
                                              //padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                                              padding: EdgeInsets.all(5),
                                              child: const Text("休息中",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      height: 1.0)),
                                            )
                                          ]),
                                        )),
                                        Container(
                                            child: const Align(
                                          alignment: Alignment.topLeft,
                                          child: (Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 14,
                                              ), // 图标
                                              Text(
                                                '配送费3元',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 95, 95, 95)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 14,
                                              ), // 图标
                                              Text(
                                                '配送时长:约15min',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 95, 95, 95)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 14,
                                              ), // 图标
                                              Text(
                                                '销量:1000+',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 95, 95, 95)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          )),
                                        )),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Container(
                                          height: 1, // 实线的高度
                                          color: const Color.fromARGB(
                                              66, 0, 0, 0), // 实线的颜色
                                        ),
                                        Text(
                                          "宁工食堂提供多样化美食，注重营养与口味的平衡，环境舒适，欢迎各位同学前来品尝",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))),
              // Padding(padding: EdgeInsets.all(11)),
            ];
          },
          body: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    flex: 1,
                    child: Material(
                        color: const Color.fromARGB(255, 244, 240, 240),
                        //进行裁切，不然滚动条的背景颜色会滚出父容器
                        child: ListViewObserver(
                          controller: observerController2,
                          //controller: observerController,
                          child: ListView.builder(
                            itemCount: categoryList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Obx(
                                () {
                                  var item = categoryList[index]['name'];
                                  bool isSel =
                                      controller.selectedIndex.value == index;
                                  return ListTile(
                                    splashColor: Colors.transparent,
                                    title: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    tileColor: const Color.fromARGB(
                                        255, 244, 240, 240),
                                    selectedTileColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    textColor:
                                        const Color.fromARGB(255, 67, 67, 67),
                                    selectedColor:
                                        const Color.fromARGB(255, 0, 0, 0),
                                    selected: isSel,
                                    onTap: () {
                                      observerController.animateTo(
                                        index: index,
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.ease,
                                      );

                                      controller.selectedIndex.value = index;
                                      print(categoryList[index]['id']);
                                    },
                                  );
                                },
                              );
                            },
                            //controller: scrollController2,
                            padding: EdgeInsets.only(
                                bottom: 70, left: 0, top: 0, right: 0),
                          ),
                        ))),
                Flexible(
                  flex: 3,
                  child: ListViewObserver(
                    onObserve: (resultModel) {
                      if (resultModel.firstChild?.index != null) {
                        controller.selectedIndex.value =
                            (resultModel.firstChild?.index)!;
                        // debugPrint('visible -- ${resultModel.visible}');
                        // debugPrint(
                        //     'firstChild.index -- ${resultModel.firstChild?.index}');
                        // debugPrint(
                        //     'displaying -- ${resultModel.displayingChildIndexList}');
                      }

                      // for (var item in resultModel.displayingChildModelList) {
                      //   debugPrint(
                      //       'item - ${item.index} - ${item.leadingMarginToViewport} - ${item.trailingMarginToViewport}');
                      // }
                    },
                    controller: observerController,
                    child: ListView.builder(
                      itemCount: categoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Obx(() {
                          String categoryName = categoryList[index]['name'];
                          return StickyHeader(
                              header: Container(
                                width: double.maxFinite,
                                color: Colors.white,
                                child: Text(
                                  categoryName,
                                  style: TextStyle(
                                      fontSize: 12,
                                      decoration: TextDecoration.none,
                                      color: Colors.black),
                                ),
                              ),
                              content: Column(
                                  //mainAxisSize: MainAxisSize.min,
                                  children: List.generate(
                                      categoryMap[categoryName].length,
                                      (itemIndex) {
                                return Container(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  padding: EdgeInsets.all(2),
                                  height: 80,
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          flex: 2,
                                          child: AspectRatio(
                                            aspectRatio: 16 / 12,
                                            child: Image(
                                                image: NetworkImage(
                                                  categoryMap[categoryName]
                                                      [itemIndex]['image'],
                                                ),
                                                fit: BoxFit.cover,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object error,
                                                    StackTrace? stackTrace) {
                                                  return const Image(
                                                    image: NetworkImage(
                                                        'https://zhoun-jun-jie-1.oss-cn-hangzhou.aliyuncs.com/nbgc2.jpg?x-oss-process=style/test'),
                                                    fit: BoxFit.cover,
                                                  );
                                                }),
                                          )),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Flexible(
                                          flex: 3,
                                          child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    categoryMap[categoryName]
                                                        [itemIndex]['name'],
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        decoration:
                                                            TextDecoration.none,
                                                        color: Colors.black),
                                                  ),
                                                  const Text(
                                                    '销量100+',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        decoration:
                                                            TextDecoration.none,
                                                        color: const Color
                                                            .fromARGB(
                                                            188, 82, 82, 82)),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  SizedBox(
                                                    height: 0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '￥${categoryMap[categoryName][itemIndex]['price']}',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            color:
                                                                Color.fromARGB(
                                                                    187,
                                                                    0,
                                                                    0,
                                                                    0)),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      DynamicActionButton(
                                                        dishData: categoryMap[
                                                                categoryName]
                                                            [itemIndex],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )))
                                    ],
                                  ),
                                );
                              })));
                        });
                      },
                      padding: EdgeInsets.only(
                          bottom: 70, left: 0, top: 0, right: 0),
                      controller: scrollController,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 25,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.circular(55), // 圆角半径
            ),
            width: 360,
            height: 50,
            //color: Colors.red,

            child: Row(
              children: [
                SizedBox(
                  width: 110,
                ),
                Expanded(
                  child: Text(
                    "￥999",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('去结算'),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 15,
            left: 40,
            child: Image(
              image: NetworkImage(
                  "https://zhoun-jun-jie-1.oss-cn-hangzhou.aliyuncs.com/btn_waiter_sel.png?x-oss-process=style/test"),
              height: 80,
            )
            //color: Colors.red,
            ),
      ],
    );
  }
}

class DynamicActionButton extends StatefulWidget {
  final dynamic dishData;
  const DynamicActionButton({super.key, this.dishData});
  @override
  State<DynamicActionButton> createState() => _DynamicActionButtonState();
}

class _DynamicActionButtonState extends State<DynamicActionButton> {
  @override
  Widget build(BuildContext context) {
    var dishData = widget.dishData;
    if (dishData['value'] == null || dishData['value'] == "") {
      String key = dishData['id'].toString();
      return Obx(() {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (shoppingCart[key] != null && shoppingCart[key] != 0)
              GestureDetector(
                //iconbutton有默认最小尺寸，所以换一个
                onTap: () {
                  shoppingCart[key] = shoppingCart[key]! - 1;
                  if (shoppingCart[key] == 0) shoppingCart.remove(key);
                },
                child: Icon(
                  Icons.remove,
                  size: 20,
                ),
              ),
            SizedBox(
              width: 4,
            ),
            if (shoppingCart[key] != null && shoppingCart[key] != 0)
              Text(
                shoppingCart[key].toString(),
                style: TextStyle(fontSize: 15, decoration: TextDecoration.none),
                textAlign: TextAlign.left,
              ),
            SizedBox(
              width: 4,
            ),
            GestureDetector(
              onTap: () {
                if (shoppingCart[key] == null) shoppingCart[key] = 0;
                shoppingCart[key] = shoppingCart[key]! + 1;
                //showMsg(context, "添加成功");
              },
              child: Icon(
                Icons.add,
                size: 20,
              ),
            ),
            Padding(padding: EdgeInsets.all(0))
          ],
        );
      });
    }

    return SizedBox(
      height: 0,
    );
  }
}

RxMap<String, int> shoppingCart = RxMap<String, int>();

mixin orders on State<order> {
  ScrollController scrollController = ScrollController(); //菜品列表控制器1
  ScrollController scrollController2 = ScrollController(); //分类列表控制器1
  ListObserverController observerController =
      ListObserverController(); //菜品列表控制器2
  ListObserverController observerController2 =
      ListObserverController(); //分类列表控制器2
  List<Future> futures = [];
  final ListController controller = Get.put(ListController()); //分类列表选中控制器
  List<bool> sel = [];
  RxList<dynamic> categoryList = <dynamic>[].obs;
  List<Future> futureList = [];
  RxMap<String, dynamic> categoryMap = RxMap<String, dynamic>();

  getCategory() async {
    Dio.Dio dio = Dio.Dio(); // 创建 Dio 实例
    Dio.Response response; // 定义响应对象
    response = await dio.get("http://10.0.2.2:8080/user/category/list");
    Map<String, dynamic> map = jsonDecode(response.toString());

    categoryList.value = map['data'];
    for (var category in categoryList) {
      if (category['type'] == 1) {
        futureList.add(dio.get(
          "http://10.0.2.2:8080/admin/dish/list",
          queryParameters: {'categoryId': category['id']},
        ).then((responses) {
          categoryMap[category['name']] = responses.data['data'];
          print(categoryMap[category['name']]);
        }));
      }

      if (category['type'] == 2) {
        futureList.add(dio.get(
          "http://10.0.2.2:8080/user/setmeal/list",
          queryParameters: {'categoryId': category['id']},
        ).then((responses) {
          categoryMap[category['name']] = responses.data['data'];
          print(categoryMap[category['name']]);
        }).catchError((e) {
          print("错误:" + e.toString());
        }));
      }
    }
    await Future.wait(futureList);
    //print(categoryList);

    setState(() {
      categoryList = categoryList;
      categoryMap = categoryMap;
    });
  }

  @override
  void initState() {
    getCategory();
    observerController = ListObserverController(controller: scrollController);
    observerController2 = ListObserverController(controller: scrollController2);
    controller.selectedIndex.value = 0;
  }
}
