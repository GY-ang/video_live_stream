import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:video_live_stream/live_stream_homePage/discover_page/discover_page.dart';

//定义主播状态
//获取用户定位
//请求附近主播数据
//按距离排序
class AnchorProvider extends ChangeNotifier {
  List<NearbyAnchor> _anchors = [];
  bool _isLoading = false;
  String? _error;
  bool _isDispoer = false;
  // ignore: unused_field
  Position? _current;

  List<NearbyAnchor> get anchors => _anchors;
  bool get isLoading => _isLoading;
  String? get error => _error;
  @override
  void notifyListeners() {
    if (!_isDispoer) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDispoer = true;
    super.dispose();
  }

  //初始化获取定位和数据
  Future<void> initData() async {
    if (_isLoading) return;
    _isLoading = true;
    _error = null;
    notifyListeners(); //通知显示加载圆圈
    try {
      _current = await permission();
      // 1. 调用你之前的定位权限逻辑
      // 2. 模拟网络请求

      await Future.delayed(const Duration(seconds: 2));
      // 模拟排序逻辑：根据距离从小到大排序
      _anchors = List<NearbyAnchor>.from(VideoDiscoverPage.mockData);
      _anchors.sort((a, b) => a.distance.compareTo(b.distance));
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners(); //刷新ui展现界面
    }
    ;
  }
}

Future<Position> permission() async {
  // 1. 检查定位服务是否开启
  bool serviceEnable = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnable) return Future.error('定位未开启');
  // 2. 检查并请求权限
  LocationPermission perm = await Geolocator.checkPermission();
  //判断权限是否开启
  if (perm == LocationPermission.denied) {
    perm = await Geolocator.requestPermission();
    if (perm == LocationPermission.denied) {
      return Future.error('权限未开启');
    }
  }
  const LocationSettings Settings = LocationSettings(accuracy: LocationAccuracy.low, distanceFilter: 1000); //移动超过1000米才触发位置更新
  return await Geolocator.getCurrentPosition(locationSettings: Settings);
}
