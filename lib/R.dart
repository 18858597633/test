/// 网络结果数据

class R {
  
  int? code;//状态码1表示成功，其他表示失败
  String? msg;//返回的数据
  dynamic? data;//返回的错误信息
  R(this.data,  this.code, this.msg);

  factory R.fromJson(Map<String, dynamic> json) {
    return R(
      json['data'],   // 解析 data 字段
      json['code'],   // 解析 code 字段
      json['msg'],    // 解析 msg 字段
    );
  }
}