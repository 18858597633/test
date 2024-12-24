import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert'; // 导入编码转换库

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '蓝牙扫描与连接',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BleHomePage(),
    );
  }
}

class BleHomePage extends StatefulWidget {
  @override
  _BleHomePageState createState() => _BleHomePageState();
}

class _BleHomePageState extends State<BleHomePage> {
  final FlutterReactiveBle _ble = FlutterReactiveBle();

  final Map<String, DiscoveredDevice> _foundDevices = {};
  final Set<String> _connectedDevices = {};
  final Map<String, StreamSubscription<ConnectionStateUpdate>> _connectionSubscriptions = {};
  final Map<String, StreamSubscription<List<int>>> _characteristicSubscriptions = {}; // 用于存储特性订阅
  StreamSubscription? _scanSubscription;

  // 存储设备服务和特性的 UUID
  final Uuid _serviceUuid = Uuid.parse("0000ffe0-0000-1000-8000-00805f9b34fb"); // 示例服务 UUID
  final Uuid _characteristicUuid = Uuid.parse("0000ffe1-0000-1000-8000-00805f9b34fb"); // 示例特性 UUID

  // 存储接收到的数据
  final Map<String, String> _deviceData = {};

  @override
  void dispose() {
    _scanSubscription?.cancel();
    for (var subscription in _connectionSubscriptions.values) {
      subscription.cancel();
    }
    for (var subscription in _characteristicSubscriptions.values) {
      subscription.cancel();
    }
    super.dispose();
  }

  void _startScan() async {
    await _requestPermissions();

    _foundDevices.clear();
    _scanSubscription = _ble.scanForDevices(
      withServices: [], // 扫描所有设备
      scanMode: ScanMode.lowLatency,
    ).listen((device) {
      setState(() {
        _foundDevices[device.id] = device;
      });
    }, onError: (error) {
      print('扫描错误: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('扫描错误: $error')),
      );
    });
  }

  void _stopScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
    setState(() {});
  }

  void _connectToDevice(DiscoveredDevice device) {
    if (_connectedDevices.contains(device.id)) {
      _disconnectFromDevice(device);
      return;
    }

    final connection = _ble
        .connectToDevice(
      id: device.id,
      connectionTimeout: const Duration(seconds: 5),
    )
        .listen((connectionState) {
      if (connectionState.connectionState == DeviceConnectionState.connected) {
        setState(() {
          _connectedDevices.add(device.id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('连接成功: ${device.name}')),
        );
        // 在连接成功后，可以发现服务
        _discoverServices(device.id);
      } else if (connectionState.connectionState == DeviceConnectionState.disconnected) {
        _disconnectFromDevice(device);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('断开连接: ${device.name}')),
        );
      }
    }, onError: (error) {
      print('连接错误: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('连接失败: $error')),
      );
    });

    _connectionSubscriptions[device.id] = connection;
  }

  void _disconnectFromDevice(DiscoveredDevice device) {
    _connectionSubscriptions[device.id]?.cancel();
    _connectionSubscriptions.remove(device.id);
    _characteristicSubscriptions[device.id]?.cancel();
    _characteristicSubscriptions.remove(device.id);
    setState(() {
      _connectedDevices.remove(device.id);
      _deviceData.remove(device.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('断开连接: ${device.name}')),
    );
  }

  // 发现服务
  Future<void> _discoverServices(String deviceId) async {
    print(deviceId);
    try {
      final services = await _ble.discoverServices(deviceId);
      for (var service in services) {
        print('发现服务: ${service.serviceId}');
        if (service.serviceId == _serviceUuid) { // 检查是否是目标服务
          for (var characteristic in service.characteristics) {
            print('发现特性: ${characteristic.characteristicId}');
            if (characteristic.characteristicId == _characteristicUuid) { // 检查是否是目标特性
              _subscribeToCharacteristic(deviceId, service.serviceId, characteristic.characteristicId);
            }
          }
        }
      }
    } catch (e) {
      print('发现服务错误: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('发现服务失败: $e')),
      );
    }
  }

  // 订阅特性
  void _subscribeToCharacteristic(String deviceId, Uuid serviceId, Uuid characteristicId) {
    final characteristic = QualifiedCharacteristic(
      serviceId: serviceId,
      characteristicId: characteristicId,
      deviceId: deviceId,
    );

    final subscription = _ble.subscribeToCharacteristic(characteristic).listen((data) {
      final receivedData = utf8.decode(data);
      print('收到数据来自 $deviceId: $receivedData');
      setState(() {
        _deviceData[deviceId] = receivedData;
      });
    }, onError: (error) {
      print('订阅特性错误: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('订阅特性失败: $error')),
      );
    });

    _characteristicSubscriptions[deviceId] = subscription;
  }

  // 写入数据
  Future<void> _writeData(String deviceId, String data) async {
    try {
      final characteristic = QualifiedCharacteristic(
        serviceId: _serviceUuid,
        characteristicId: _characteristicUuid,
        deviceId: deviceId,
      );

      // 将字符串转换为字节数组
      final bytes = utf8.encode(data);

      await _ble.writeCharacteristicWithResponse(characteristic, value: bytes);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('写入数据成功: $data')),
      );
    } catch (e) {
      print('写入数据错误: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('写入数据失败: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('蓝牙扫描与连接'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              if (_scanSubscription == null) {
                _startScan();
              } else {
                _stopScan();
              }
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _foundDevices.isEmpty
                ? Center(
                    child: Text('未发现任何设备'),
                  )
                : ListView.builder(
                    itemCount: _foundDevices.length,
                    itemBuilder: (context, index) {
                      final device = _foundDevices.values.elementAt(index);
                      final isConnected = _connectedDevices.contains(device.id);
                      final deviceInfo = _deviceData[device.id] ?? '无数据';
                      return ListTile(
                        title: Text(device.name.isNotEmpty ? device.name : '未知设备'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(device.id),
                            if (isConnected)
                              Text('接收数据: $deviceInfo', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        tileColor: isConnected
                            ? Colors.blueAccent.withOpacity(0.3)
                            : null,
                        onTap: () {
                          _connectToDevice(device);
                        },
                        trailing: isConnected
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.send, color: Colors.green),
                                    onPressed: () {
                                      // 弹出对话框输入要写入的数据
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          String inputData = '';
                                          return AlertDialog(
                                            title: Text('写入数据'),
                                            content: TextField(
                                              onChanged: (value) {
                                                inputData = value;
                                              },
                                              decoration: InputDecoration(
                                                hintText: '输入要发送的数据',
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('取消'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  _writeData(device.id, inputData);
                                                },
                                                child: Text('发送'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  Icon(
                                    Icons.bluetooth_connected,
                                    color: Colors.blue,
                                  ),
                                ],
                              )
                            : Icon(Icons.bluetooth_disabled),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_scanSubscription == null ? Icons.play_arrow : Icons.stop),
        onPressed: () {
          if (_scanSubscription == null) {
            _startScan();
          } else {
            _stopScan();
          }
          setState(() {});
        },
        tooltip: _scanSubscription == null ? '开始扫描' : '停止扫描',
      ),
    );
  }
}

Future<void> _requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.bluetoothScan,
    Permission.bluetoothConnect,
    Permission.bluetooth,
  ].request();

  if (statuses[Permission.location] != PermissionStatus.granted ||
      statuses[Permission.bluetoothScan] != PermissionStatus.granted ||
      statuses[Permission.bluetoothConnect] != PermissionStatus.granted ||
      statuses[Permission.bluetooth] != PermissionStatus.granted) {
    print('需要授予必要的权限');
  }
}
