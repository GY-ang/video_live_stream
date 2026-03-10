import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 消息模型 (保持不变)
enum MessageType { text, image, voice }

class MessageModel {
  final String id;
  final String content;
  final MessageType type;
  final bool isMe;
  final DateTime timestamp;

  MessageModel({required this.id, required this.isMe, required this.timestamp, required this.content, this.type = MessageType.text});
}

// 2. Provider 定义
final messageProvider = NotifierProvider.family<MessageNotifier, List<MessageModel>, String>((String roomId) => MessageNotifier(roomId));

// 3. Notifier 类
class MessageNotifier extends Notifier<List<MessageModel>> {
  final String roomId;
  MessageNotifier(this.roomId);

  @override
  List<MessageModel> build() {
    // 这里的 arg 就是传进来的 chatId
    // 模拟数据
    return [
      MessageModel(id: '1', content: '欢迎来到的聊天室', isMe: false, timestamp: DateTime.now().subtract(const Duration(minutes: 5))),
      MessageModel(id: '2', content: '我们在 M1 Pro 上解决了继承报错！', isMe: true, timestamp: DateTime.now()), //
    ];
  }

  // 发送信息方法
  void sendMessage(String text) {
    if (text.isEmpty) return;
    final newMessage = MessageModel(id: DateTime.now().millisecondsSinceEpoch.toString(), isMe: true, timestamp: DateTime.now(), content: text);
    // 更新状态：利用不可变数据特性，触发 UI 刷新
    state = [newMessage, ...state];
  }
}
