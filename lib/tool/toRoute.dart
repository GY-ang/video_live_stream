//统一管理整个项目的路由
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_live_stream/live_stream_message/contact/contact_UI/search_friend.dart';
import 'package:video_live_stream/live_stream_message/message/message_UI/chat_page.dart';
import 'package:video_live_stream/live_stream_message/message/message_UI/message_page.dart';
import 'package:video_live_stream/live_stream_message/message_page.dart';
import 'package:video_live_stream/main.dart';

class Approute {
  // 1. 定义全局唯一 Key，用于在没有 Context 的地方跳转（比如 Token 失效自动跳登录）
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  //
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey, //把GoRouter绑定到全局Navigator
    initialLocation: '/', //应用启动时默认进入的页面('/')表示首页
    routes: [
      //1，首页
      GoRoute(path: '/', name: 'Mylivestream', builder: (context, state) => const Mylivestream()),
      //2,消息(消息Tab)
      GoRoute(
        path: '/message', //路由地址
        name: 'message',
        builder: (context, state) => const MessagePage(),
      ),
      GoRoute(path: '/VideoMessage', name: 'VideoMessage', builder: (context, state) => const VideoMessagePage()),
      // 3. 聊天详情页（作为子路由，路径不加 /）
      GoRoute(
        path: '/chat/:chatId',
        name: 'chat',
        builder: (context, state) {
          final id = state.pathParameters['chatId'] ?? '';
          return ChatPage(chatId: id);
        },
      ),
      //4. 联系人添加好友(子路由)
      GoRoute(path: '/AddFriend', name: 'AddFriend', builder: (context, state) => const AddFriendPage()),
    ],
    //错误处理：找不到页面时跳转404
    errorBuilder: (context, state) => const Scaffold(body: Center(child: Text('404 Not found'))),
  );
}
