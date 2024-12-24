import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  StreamSubscription<DiscoveredDevice>? _scanSubscription;
  StreamSubscription<ConnectionStateUpdate>? _connection;
  List<DiscoveredDevice> _foundDevices = [];
  DiscoveredDevice? _connectedDevice;
  List<DiscoveredService> _services = [];

  // 替换为实际的服务 UUID 和特征 UUID
  final Uuid _serviceUuid = Uuid.parse("YOUR_SERVICE_UUID");
  final Uuid _characteristicUuid = Uuid.parse("YOUR_CHARACTERISTIC_UUID");

  @override
  void dispose() {
    _scanSubscription?.cancel();
    _connection?.cancel();
    super.dispose();
  }

  void startScan() {
    _foundDevices.clear();
    _scanSubscription = _ble.scanForDevices(
      withServices: [],
      scanMode: ScanMode.lowLatency,
    ).listen((device) {
      if (!_foundDevices.any((d) => d.id == device.id)) {
        setState(() {
          _foundDevices.add(device);
        });
      }
    }, onError: (error) {
      print('扫描错误: $error');
    });
  }

  void stopScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
  }

  void connectToDevice(DiscoveredDevice device) {
    _connection = _ble.connectToDevice(
      id: device.id,
      connectionTimeout: const Duration(seconds: 10),
    ).listen((connectionState) {
      print('连接状态: ${connectionState.connectionState}');
      if (connectionState.connectionState == DeviceConnectionState.connected) {
        setState(() {
          _connectedDevice = device;
        });
        discoverServices(device.id);
      }
    }, onError: (error) {
      print('连接错误: $error');
    });
  }

  Future<void> discoverServices(String deviceId) async {
    _services = await _ble.discoverServices(deviceId);
    setState(() {});
  }

  Future<void> sendCommand(String command) async {
    if (_connectedDevice == null) return;

    final QualifiedCharacteristic characteristic = QualifiedCharacteristic(
      serviceId: _serviceUuid,
      characteristicId: _characteristicUuid,
      deviceId: _connectedDevice!.id,
    );

    List<int> commandBytes = utf8.encode(command);

    try {
      await _ble.writeCharacteristicWithResponse(characteristic, value: commandBytes);
      print('命令发送成功: $command');
    } catch (e) {
      print('发送命令失败: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Reactive BLE 示例',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Reactive BLE 示例'),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: startScan,
            ),
          ],
        ),
        body: Column(
          children: [
            _connectedDevice == null
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _foundDevices.length,
                      itemBuilder: (context, index) {
                        final device = _foundDevices[index];
                        return ListTile(
                          title: Text(device.name.isNotEmpty ? device.name : "未知设备"),
                          subtitle: Text(device.id),
                          onTap: () {
                            stopScan();
                            connectToDevice(device);
                          },
                        );
                      },
                    ),
                  )
                : Column(
                    children: [
                      ListTile(
                        title: Text('已连接设备'),
                        subtitle: Text(_connectedDevice!.name.isNotEmpty
                            ? _connectedDevice!.name
                            : "未知设备"),
                      ),
                      ElevatedButton(
                        onPressed: () => sendCommand("POWER_ON"),
                        child: Text('开机'),
                      ),
                      ElevatedButton(
                        onPressed: () => sendCommand("SWITCH_MODE:MODE1"),
                        child: Text('切换到模式1'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // 断开连接
                          _connection?.cancel();
                          setState(() {
                            _connectedDevice = null;
                            _services.clear();
                          });
                        },
                        child: Text('断开连接'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
