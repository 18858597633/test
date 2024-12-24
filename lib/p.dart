import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // 根组件
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '自定义页面',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false, // 去掉右上角的debug标志
    );
  }
}

class HomePage extends StatelessWidget {
  // 主页面
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // 页面背景灰色
      body: Column(
        children: [
          // 上半部分A
          Expanded(
            flex: 1, // 上半部分占屏幕的1份
            child: Stack(
              children: [
                // 背景图片
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://zhoun-jun-jie-1.oss-cn-hangzhou.aliyuncs.com/nbgc2.jpg?x-oss-process=style/test'),
                      fit: BoxFit.cover,
                      
                    ),
                    
                  ),
                ),
                // 个人信息和搜索栏
                const SizedBox(
                          width: 33,
                        ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 个人信息
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                'https://via.placeholder.com/150'), // 个人头像
                          ),
                          SizedBox(width: 10),
                          Text(
                            '用户名',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      // 搜索图标
                      IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          // 搜索按钮的操作
                        },
                      ),
                    ],
                  ),
                ),
                // 底部的卡片C
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          // 左侧图标
                          Icon(
                            Icons.account_circle,
                            size: 40,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 16),
                          // 右侧信息
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '卡片名称',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '一些详细信息',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 下半部分B
          Expanded(
            flex: 3, // 下半部分占屏幕的1份
            child: Row(
              children: [
                // 左侧D：分类列表
                Container(
                  width: 100,
                  color: Colors.white,
                  child: ListView(
                    children: [
                      ListTile(
                        title: Text('分类1'),
                        onTap: () {
                          // 分类1的操作
                        },
                      ),
                      ListTile(
                        title: Text('分类2'),
                        onTap: () {
                          // 分类2的操作
                        },
                      ),
                      ListTile(
                        title: Text('分类3'),
                        onTap: () {
                          // 分类3的操作
                        },
                      ),
                      // 添加更多分类
                    ],
                  ),
                ),
                // 右侧E：类似卡片C的列表
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.grey[200],
                    child: ListView.builder(
                      itemCount: 10, // 示例列表项数
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.category,
                              color: Colors.blue,
                            ),
                            title: Text('列表项 ${index + 1}'),
                            subtitle: Text('详细信息 ${index + 1}'),
                            onTap: () {
                              // 列表项的操作
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
