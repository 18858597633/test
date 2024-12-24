import 'package:dio/dio.dart ' as Dio;
import 'package:flutter/material.dart';
import 'package:nbut_take_out/AJ-Captcha/loadingBlockPuzzle.dart';
import 'package:nbut_take_out/input.dart';
import 'package:nbut_take_out/icon.dart';
import 'package:nbut_take_out/R.dart';
import 'package:nbut_take_out/anim_bg_demo_page.dart';
import 'package:nbut_take_out/test.dart';
import 'package:get/get.dart';
import 'package:nbut_take_out/index.dart';
import 'package:nbut_take_out/order.dart';
import 'package:nbut_take_out/api.dart';
class LoginPage extends StatefulWidget {
  // 创建一个 LoginPage 的 StatefulWidget
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState(); // 创建与 LoginPage 关联的状态类
}

class _LoginPageState extends State<LoginPage> with login {
  // 定义登录页面的状态类，并混入登录功能
  @override
  Widget build(BuildContext context) {
    // 构建界面的方法
    return GestureDetector(
      // GestureDetector用于检测手势的组件
      onTap: () {
        FocusScope.of(context)
            .requestFocus(FocusNode()); // 获得一个空焦点，完成点击空白区域失去焦点功能
      },
      behavior: HitTestBehavior.translucent, // 子组件有手势时本身也处理手势
      child: Scaffold(
        // Scaffold是一个页面的脚手架结构组件
        body: Container(
          // 外层容器组件
          child: Stack(
            // Stack用于堆叠子组件
            children: [
              const Positioned.fill(
                  child: AnimBgDemoPage("欢迎来到宁工食堂 !")), // 填充整个页面的背景动画
              Center(
                // 将子组件置于页面中央
                child: SafeArea(
                  // 确保子组件不会被系统界面元素遮挡
                  child: Card(
                    // Card组件用于展示卡片式内容
                    elevation: 5, // 设置阴影效果
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(10.0)), // 设置圆角
                    ),
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0), // 设置卡片与屏幕两侧的距离
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0,
                          top: 10.0,
                          right: 30.0,
                          bottom: 10.0), // 设置内部组件的边距
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // 子组件居中排列
                        mainAxisSize: MainAxisSize.min, // 设置为包裹组件内容，非默认全屏
                        children: <Widget>[
                          Image.network(
                            "https://zhoun-jun-jie-1.oss-cn-hangzhou.aliyuncs.com/nbgc.png?x-oss-process=style/test",
                            height: 100, // 图片高度
                            width: 100, // 图片宽度
                          ),
                          Padding(padding: EdgeInsets.all(3)), // 添加上下间距
                          InputWidget(
                            // 自定义输入框组件
                            controller: phoneController, // 绑定手机号输入框的控制器
                            hintText: "请输入手机号", // 提示文本
                            iconData: ICONS.phone, // 使用自定义图标
                          ),
                          const Padding(
                              padding: EdgeInsets.all(10.0)), // 添加换行间距
                          InputWidget(
                            // 自定义输入框组件
                            controller: passwordController, // 绑定密码输入框的控制器
                            hintText: "请输入密码", // 提示文本
                            iconData: ICONS.password, // 使用自定义图标
                            obscureText: true, // 隐藏文本内容
                          ),
                          const Padding(
                              padding: EdgeInsets.all(10.0)), // 添加换行间距
                          Row(
                            // 行布局
                            children: [
                              Expanded(
                                // 让按钮填充剩余宽度
                                child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    splashFactory:
                                        InkRipple.splashFactory, // 按钮点击效果
                                    backgroundColor: Colors.blue, // 设置背景颜色
                                    padding: const EdgeInsets.only(
                                        left: 20.0,
                                        top: 10.0,
                                        right: 20.0,
                                        bottom: 10.0), // 按钮内边距
                                  ),
                                  onPressed: loginIn, // 按钮点击事件，执行登录逻辑
                                  child: const Flex(
                                    // 使用Flex来控制子组件的方向和布局
                                    mainAxisAlignment:
                                        MainAxisAlignment.center, // 子组件居中
                                    direction: Axis.horizontal, // 水平布局
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          "登录/注册", // 按钮文字
                                          style: TextStyle(
                                              color: Colors.white), // 字体颜色
                                          textAlign: TextAlign.center, // 居中文字
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10, // 按钮之间的间距
                              ),
                              Expanded(
                                // 让按钮填充剩余宽度
                                child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    splashFactory:
                                        InkRipple.splashFactory, // 按钮点击效果
                                    backgroundColor: Colors.blue, // 设置背景颜色
                                    padding: const EdgeInsets.only(
                                        left: 20.0,
                                        top: 10.0,
                                        right: 20.0,
                                        bottom: 10.0), // 按钮内边距
                                  ),
                                  onPressed: () {}, // 点击事件（未实现）
                                  child: const Flex(
                                    // 使用Flex来控制子组件的方向和布局
                                    mainAxisAlignment:
                                        MainAxisAlignment.center, // 子组件居中
                                    direction: Axis.horizontal, // 水平布局
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          "忘记密码？", // 按钮文字
                                          style: TextStyle(
                                              color: Colors.white), // 字体颜色
                                          textAlign: TextAlign.center, // 居中文字
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            // 一行布局，用于勾选框和用户协议
                            crossAxisAlignment:
                                CrossAxisAlignment.center, // 垂直方向居中
                            mainAxisSize: MainAxisSize.min, // 根据子组件最小宽度排列
                            children: [
                              Transform.scale(
                                scale: 0.8, // 缩小勾选框
                                child: Checkbox(
                                  value: isChecked, // 当前是否勾选
                                  onChanged: (bool? value) {
                                    // 勾选变化事件
                                    setState(() {
                                      isChecked = value ?? false; // 更新状态
                                    });
                                  },
                                ),
                              ),
                              const Text.rich(
                                // 富文本
                                TextSpan(
                                  text: '我已阅读并同意', // 文本
                                  style: TextStyle(fontSize: 14), // 文本样式
                                  children: [
                                    TextSpan(
                                      text: '《用户协议》', // 高亮部分
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue,
                                          decoration:
                                              TextDecoration.underline), // 下划线
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

mixin login on State<LoginPage> {
  // 定义登录逻辑的 mixin
  final TextEditingController phoneController =
      TextEditingController(); // 手机号输入框控制器
  final TextEditingController passwordController =
      TextEditingController(); // 密码输入框控制器
  bool isChecked = false; // 用户协议勾选状态
  String phone = ""; // 手机号
  String password = ""; // 密码

  loginIn() async {
    // 登录逻辑
    if (!isChecked) {
      // 如果协议未勾选
      showMsg(context, "请先勾选协议"); // 提示用户
      return null;
    }
    if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
      // 如果手机号或密码为空
      showMsg(context, "账号/密码为空"); // 提示用户
      return null;
    }
    
    Dio.Dio dio = Dio.Dio(); // 创建 Dio 实例
    Dio.Response response; // 定义响应对象
    // 进行人机验证
    bool? isVerified = await loadingBlockPuzzle(context);
          
    if (isVerified == false) {
      showMsg(context, "请先通过人机验证");
      return null; // 退出当前函数或操作
    }
    showMsg(context, "验证成功");
    response = await dio.post(
      "http://10.0.2.2:8080/user/user/login2", // 模拟器本地地址
      data: {
        'phone': phoneController.text, // 请求中的手机号
        'password': passwordController.text, // 请求中的密码
      },
    );
    R r = R.fromJson(response.data); // 将响应数据转为 R 对象
    if (r.code == 0 && r.msg != null) {
      // 如果登录失败，显示错误信息
      showMsg(context, r.msg!);
      return null;
    } else {
      showMsg(context, "登录成功,正在跳转页面..."); // 登录成功提示
      Get.to(Toolbar(), arguments: 'Hello from Home Page!'); // 跳转到详情页
    }
  }
}

OverlayEntry? currentOverlayEntry; // 当前显示的 OverlayEntry
bool isOverlayVisible = false; // 记录弹窗是否显示

void showMsg(BuildContext context, String msg) {
  // 显示消息弹窗
  if (isOverlayVisible && currentOverlayEntry != null) {
    // 如果已有弹窗显示，先移除
    currentOverlayEntry!.remove();
    currentOverlayEntry = null;
    isOverlayVisible = false;
  }
  final overlay = Overlay.of(context); // 获取 Overlay 对象
  if (overlay == null) return; // 确保 overlay 不为 null
  currentOverlayEntry = OverlayEntry(
  builder: (context) => IgnorePointer(
    ignoring: true, // 忽略所有事件，允许点击穿透
    child: Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            msg,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  ),
);

  overlay.insert(currentOverlayEntry!); // 显示新的 OverlayEntry
  isOverlayVisible = true;
  Future.delayed(const Duration(seconds: 2), () {
    // 两秒后自动移除弹窗
    if (isOverlayVisible && currentOverlayEntry != null) {
      currentOverlayEntry!.remove();
      currentOverlayEntry = null;
      isOverlayVisible = false;
    }
  });
}
