import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';

import 'package:permission_handler/permission_handler.dart';
class bdMap extends StatefulWidget {
  const bdMap({super.key});

  @override
  State<bdMap> createState() => _bdMapState();
}

class _bdMapState extends State<bdMap> {
   
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

































import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';

import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';

import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  runApp(const MyApp());

  // 设置用户是否同意SDK隐私协议
  BMFMapSDK.setAgreePrivacy(true);

  // 动态申请定位权限
  // since 3.1.0 开发者必须设置
  requestPermission();

  LocationFlutterPlugin myLocPlugin = LocationFlutterPlugin();
  myLocPlugin.setAgreePrivacy(true);

  // 百度地图sdk初始化鉴权
  if (Platform.isIOS) {
    
    myLocPlugin.authAK('tHRvlMm3IO2JmJP3am3L8HLCCuG8SRIS');
    BMFMapSDK.setApiKeyAndCoordType(
        'tHRvlMm3IO2JmJP3am3L8HLCCuG8SRIS', BMF_COORD_TYPE.BD09LL);
  } else if (Platform.isAndroid) {
    await BMFAndroidVersion.initAndroidVersion();
    // Android 目前不支持接口设置Apikey,
    // 请在主工程的Manifest文件里设置，详细配置方法请参考官网(https://lbsyun.baidu.com/)demo
    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
  }

  Map? map = await BMFMapBaseVersion.nativeBaseVersion;
  print('获取原生地图版本号：$map');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

BMFMapController? dituController;

class _MyHomePageState extends State<MyHomePage> {
  BMFMapOptions mapOptions = BMFMapOptions(
      center: BMFCoordinate(29.886134, 121.53632),
      zoomLevel: 20,
      mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));

//   创建完成回调
  void onBMFMapCreated(BMFMapController controller) {
    dituController = controller;

    /// 地图加载回调
    dituController?.setMapDidLoadCallback(callback: () {
      print('mapDidLoad-地图加载完成!!!');
      dituController?.showUserLocation(true);
      BMFCoordinate coordinate = BMFCoordinate(29.886134, 121.53632);

      BMFLocation location = BMFLocation(
          coordinate: coordinate,
          altitude: 0,
          horizontalAccuracy: 5,
          verticalAccuracy: -1.0,
          speed: -1.0,
          course: -1.0);

      BMFUserLocation userLocation = BMFUserLocation(
        location: location,
      );

      dituController?.updateLocationData(userLocation);

      BMFUserLocationDisplayParam displayParam = BMFUserLocationDisplayParam(
          locationViewOffsetX: 0,
          locationViewOffsetY: 0,
          accuracyCircleFillColor: Colors.red,
          accuracyCircleStrokeColor: Colors.blue,
          isAccuracyCircleShow: true,
          locationViewImage: 'images/animation_red.png',
          locationViewHierarchy:
              BMFLocationViewHierarchy.LOCATION_VIEW_HIERARCHY_TOP);

      dituController?.updateLocationViewWithParam(displayParam);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Container(
              height: screenSize.height,
              width: screenSize.width,
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: BMFMapWidget(
                      onBMFMapCreated: (controller) {
                        onBMFMapCreated(controller);
                      },
                      mapOptions: mapOptions,
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: TextButton(
                        onPressed: _getCurrentLocation,
                        child: Text("date"),
                      ))
                ],
              ))),
    );
  }

  void _getCurrentLocation() {
    initializeAndStartLocation((BaiduLocation location) {
      if (location != null) {
        print('纬度: ${location.latitude}');
        print('经度: ${location.longitude}');
        print('地址: ${location.address}');
      } else {
        print('获取定位失败');
      }
    });
  }

  Future<void> initializeAndStartLocation(
      Function(BaiduLocation) onLocationResult) async {
    // 构造检索参数
    BMFReverseGeoCodeSearchOption reverseGeoCodeSearchOption =
        BMFReverseGeoCodeSearchOption(
            location: BMFCoordinate(29.886134, 121.53632));
// 检索实例
    BMFReverseGeoCodeSearch reverseGeoCodeSearch = BMFReverseGeoCodeSearch();
// 逆地理编码回调
    reverseGeoCodeSearch.onGetReverseGeoCodeSearchResult(callback:
        (BMFReverseGeoCodeSearchResult result, BMFSearchErrorCode errorCode) {
      if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败" + "errorCode:${errorCode.toString()}";
      
      print(error);
      return;
    }

    

    /// 检索结果 alert msg
    List<String> alertMsgs = [];
    String lat = "纬度：" + "${result.location?.latitude}";
    String lon = "经度：" + "${result.location?.longitude}";
  
    alertMsgs.add(lat);
    alertMsgs.add(lon);
    print("经纬度"+lat+","+lon);
    });
// 发起检索
    bool flag = await reverseGeoCodeSearch
        .reverseGeoCodeSearch(reverseGeoCodeSearchOption);
    // 创建定位插件实例
    final LocationFlutterPlugin locationPlugin = LocationFlutterPlugin();

    // 定义安卓定位参数
    BaiduLocationAndroidOption androidOptions = BaiduLocationAndroidOption(
      // 定位模式，可选高精度、仅设备、仅网络，默认高精度
      locationMode: BMFLocationMode.hightAccuracy,
      // 是否需要返回地址信息
      isNeedAddress: true,
      // 是否需要返回海拔高度信息
      isNeedAltitude: true,
      // 是否需要返回周边POI信息
      isNeedLocationPoiList: true,
      // 是否需要返回新版本RGC信息
      isNeedNewVersionRgc: true,
      // 是否需要返回位置描述信息
      isNeedLocationDescribe: true,
      // 是否使用GPS
      openGps: true,
      // 定位场景参数，如运动场景
      locationPurpose: BMFLocationPurpose.sport,
      // 坐标系类型
      coordType: BMFLocationCoordType.bd09ll,
      // 定位请求的间隔，单位毫秒，0表示单次定位
      scanspan: 0,
    );

    // 获取安卓和iOS的参数映射（这里只配置安卓，iOS传空）
    Map androidMap = androidOptions.getMap();
    Map iosMap = {}; // 因为目前只需要安卓，所以传空

    // 准备定位插件，传入配置参数
    bool prepareSuccess = await locationPlugin.prepareLoc(androidMap, iosMap);
    if (!prepareSuccess) {
      print('定位插件初始化失败');
      return;
    }

    // 检查当前平台是否为安卓
    if (Platform.isAndroid) {
      // 设置安卓的连续定位回调
      locationPlugin.seriesLocationCallback(callback: (BaiduLocation result) {
        // 处理定位结果
        onLocationResult(result);
        // 如果只需要单次定位，可以在这里停止定位
        locationPlugin.stopLocation();
      });

      // 启动定位
      bool startSuccess = await locationPlugin.startLocation();
      if (!startSuccess) {
        print('启动定位失败');
      }
    } else {
      print('当前平台不支持，只有安卓平台被支持');
    }
  }
}

// 动态申请定位权限
void requestPermission() async {
  // 申请权限
  bool hasLocationPermission = await requestLocationPermission();
  if (hasLocationPermission) {
    // 权限申请通过
  } else {}
}

/// 申请定位权限
/// 授予定位权限返回true， 否则返回false
Future<bool> requestLocationPermission() async {
  //获取当前的权限
  var status = await Permission.location.status;
  if (status == PermissionStatus.granted) {
    //已经授权
    return true;
  } else {
    //未授权则发起一次申请
    status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}



Future<void> main() async {
  runApp(const MyApp());

  // 设置用户是否同意SDK隐私协议
  BMFMapSDK.setAgreePrivacy(true);

  // 动态申请定位权限
  // since 3.1.0 开发者必须设置
  requestPermission();

  LocationFlutterPlugin myLocPlugin = LocationFlutterPlugin();
  myLocPlugin.setAgreePrivacy(true);

  // 百度地图sdk初始化鉴权
  if (Platform.isIOS) {
    myLocPlugin.authAK('tHRvlMm3IO2JmJP3am3L8HLCCuG8SRIS');
    BMFMapSDK.setApiKeyAndCoordType(
        'tHRvlMm3IO2JmJP3am3L8HLCCuG8SRIS', BMF_COORD_TYPE.BD09LL);
  } else if (Platform.isAndroid) {
    // Android 目前不支持接口设置Apikey,
    // 请在主工程的Manifest文件里设置，详细配置方法请参考官网(https://lbsyun.baidu.com/)demo
    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
  }

  Map? map = await BMFMapBaseVersion.nativeBaseVersion;
  print('获取原生地图版本号：$map');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
BMFMapController? dituController;
class _MyHomePageState extends State<MyHomePage> {
  

  BMFMapOptions mapOptions = BMFMapOptions(
      center: BMFCoordinate(29.886134, 121.53632),
      zoomLevel: 20,
      mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));

//   创建完成回调
  void onBMFMapCreated(BMFMapController controller) {
    dituController = controller;
   
    /// 地图加载回调
    dituController?.setMapDidLoadCallback(callback: () {
      print('mapDidLoad-地图加载完成!!!');
       dituController?.showUserLocation(true);
    BMFCoordinate coordinate = BMFCoordinate(29.886134, 121.53632);

    BMFLocation location = BMFLocation(
        coordinate: coordinate,
        altitude: 0,
        horizontalAccuracy: 5,
        verticalAccuracy: -1.0,
        speed: -1.0,
        course: -1.0);

    BMFUserLocation userLocation = BMFUserLocation(
      location: location,
    );

    dituController?.updateLocationData(userLocation);

    BMFUserLocationDisplayParam displayParam = BMFUserLocationDisplayParam(
        locationViewOffsetX: 0,
        locationViewOffsetY: 0,
        accuracyCircleFillColor: Colors.red,
        accuracyCircleStrokeColor: Colors.blue,
        isAccuracyCircleShow: true,
        locationViewImage: 'images/animation_red.png',
        locationViewHierarchy:
            BMFLocationViewHierarchy.LOCATION_VIEW_HIERARCHY_TOP);

    dituController?.updateLocationViewWithParam(displayParam);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
     
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Container(
              height: screenSize.height,
              width: screenSize.width,
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: BMFMapWidget(
                      onBMFMapCreated: (controller) {
                        onBMFMapCreated(controller);
                      },
                      mapOptions: mapOptions,
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: TextButton(
                        onPressed: _getCurrentLocation,
                        child: Text("date"),
                      ))
                ],
              ))),
    );
  }

  void _getCurrentLocation() {
    
    initializeAndStartLocation((BaiduLocation location) {
      if (location != null) {
        print('纬度: ${location.latitude}');
        print('经度: ${location.longitude}');
        print('地址: ${location.address}');
      } else {
        print('获取定位失败');
      }
    });
  }

  Future<void> initializeAndStartLocation(
      Function(BaiduLocation) onLocationResult) async {
    // 创建定位插件实例
    final LocationFlutterPlugin locationPlugin = LocationFlutterPlugin();

    // 定义安卓定位参数
    BaiduLocationAndroidOption androidOptions = BaiduLocationAndroidOption(
      // 定位模式，可选高精度、仅设备、仅网络，默认高精度
      locationMode: BMFLocationMode.hightAccuracy,
      // 是否需要返回地址信息
      isNeedAddress: true,
      // 是否需要返回海拔高度信息
      isNeedAltitude: true,
      // 是否需要返回周边POI信息
      isNeedLocationPoiList: true,
      // 是否需要返回新版本RGC信息
      isNeedNewVersionRgc: true,
      // 是否需要返回位置描述信息
      isNeedLocationDescribe: true,
      // 是否使用GPS
      openGps: true,
      // 定位场景参数，如运动场景
      locationPurpose: BMFLocationPurpose.sport,
      // 坐标系类型
      coordType: BMFLocationCoordType.bd09ll,
      // 定位请求的间隔，单位毫秒，0表示单次定位
      scanspan: 0,
    );

    // 获取安卓和iOS的参数映射（这里只配置安卓，iOS传空）
    Map androidMap = androidOptions.getMap();
    Map iosMap = {}; // 因为目前只需要安卓，所以传空

    // 准备定位插件，传入配置参数
    bool prepareSuccess = await locationPlugin.prepareLoc(androidMap, iosMap);
    if (!prepareSuccess) {
      print('定位插件初始化失败');
      return;
    }

    // 检查当前平台是否为安卓
    if (Platform.isAndroid) {
      // 设置安卓的连续定位回调
      locationPlugin.seriesLocationCallback(callback: (BaiduLocation result) {
        // 处理定位结果
        onLocationResult(result);
        // 如果只需要单次定位，可以在这里停止定位
        locationPlugin.stopLocation();
      });

      // 启动定位
      bool startSuccess = await locationPlugin.startLocation();
      if (!startSuccess) {
        print('启动定位失败');
      }
    } else {
      print('当前平台不支持，只有安卓平台被支持');
    }
  }
}

// 动态申请定位权限
void requestPermission() async {
  // 申请权限
  bool hasLocationPermission = await requestLocationPermission();
  if (hasLocationPermission) {
    // 权限申请通过
  } else {}
}

/// 申请定位权限
/// 授予定位权限返回true， 否则返回false
Future<bool> requestLocationPermission() async {
  //获取当前的权限
  var status = await Permission.location.status;
  if (status == PermissionStatus.granted) {
    //已经授权
    return true;
  } else {
    //未授权则发起一次申请
    status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}
