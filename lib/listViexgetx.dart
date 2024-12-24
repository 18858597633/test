import 'package:get/get.dart'; // 引入 GetX 库

class ListController extends GetxController {
  // 用于记录当前选中的索引，-1 表示未选中任何项
  var selectedIndex = (-1).obs;

  // 更新选中项
  void selectItem(int index) {
    selectedIndex.value = index; // 修改状态，UI 会自动更新
  }

  
}
