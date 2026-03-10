// 模拟当前登录用户的信息
import 'package:flutter_riverpod/flutter_riverpod.dart';

final meProvider = Provider((ref) => {
  'uid': 'me_123',
  'name': '我',
  'avatar': null, // 暂时为 null，后面接入真实头像 URL
});