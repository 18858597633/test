import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nbut_take_out/AJ-Captcha/captcha/block_puzzle_captcha.dart';

Future<bool?> loadingBlockPuzzle(BuildContext context, {bool barrierDismissible = true}) async {
  // 创建一个Completer来处理返回值
  Completer<bool?> completer = Completer<bool?>();
  // 显示对话框
  showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return BlockPuzzleCaptchaPage(
        // 验证成功回调
        onSuccess: (v) {
          
          completer.complete(true); // 验证成功时返回true
        },
        // 验证失败回调
        onFail: () {
          Navigator.of(context).pop();
          completer.complete(false); // 验证失败时返回false
        },
      );
    },
  ).then((_) {
    // 监听对话框关闭时的处理
    if (!completer.isCompleted) {
      completer.complete(false); // 如果没有手动触发completer，认为是失败
    }
  });

  // 返回completer的结果，等待异步操作完成
  return completer.future;
}
