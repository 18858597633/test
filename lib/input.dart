import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({
    super.key,
    this.controller,
    this.hintText,
    this.iconData,
    this.onChanged,
    this.textStyle,
    this.obscureText = false,
  });
  final bool obscureText; //是否是密码框
  final String? hintText; //提示文本
  final IconData? iconData; //左侧显示图标
  final ValueChanged<String>? onChanged;
  final TextStyle? textStyle;
  final TextEditingController? controller;

  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      style: TextStyle(
        fontSize: 15.0,
      ),
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          // 获取焦点时的下划线样式
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.3), // 设置透明度的颜色
            width: 2.0, // 设置下划线宽度
          ),
        ),
        // 未获取焦点时的下划线样式
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.2), // 设置透明度的颜色
            width: 1.5, // 设置下划线宽度
          ),
        ),
        hintText: widget.hintText,

        hintStyle: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          color: Colors.blueGrey,
        ),
        icon: widget.iconData == null ? null : Icon(widget.iconData),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              if (widget.controller != null) widget.controller!.clear();
            });
          },
        ),
        isDense: true, // 添加此行
        contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
        // contentPadding: const EdgeInsets.symmetric(vertical: 22, horizontal: 0),
      ),
    );
  }
}
