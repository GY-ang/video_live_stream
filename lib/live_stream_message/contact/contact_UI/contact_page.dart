import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:video_live_stream/tool/index.dart';

class ContactPage extends ConsumerStatefulWidget {
  const ContactPage({super.key});

  @override
  ConsumerState<ContactPage> createState() => ContactPageState();
}

class ContactPageState extends ConsumerState<ContactPage> {
  @override
  Widget build(BuildContext context) {
    // 使用 Riverpod 监听数据，实现响应式 UI
    final List<Map<String, dynamic>> contens = ref.watch(VideoIndex.contactProvider);
    final double topPadding = MediaQuery.of(context).padding.top;
    return CustomScrollView(
      slivers: [
        //顶部添加好友的icon
        //1，顶部图标区域：随着滚动而滚动
        SliverToBoxAdapter(
          child: Container(
            width: double.infinity,
            height: topPadding + 30,
            color: Colors.white,
            padding: EdgeInsets.only(top: topPadding, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pushNamed('AddFriend');
                  },
                  child: Icon(Icons.person_add_alt_1, size: 27),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = contens[index];
            return _buildContendItem(item);
          }, childCount: contens.length),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 50)),
      ],
    );
  }

  //中间数据
  Widget _buildContendItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.network(
                  item['icon'],
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover, //
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.face),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(item['title'], maxLines: 1, overflow: TextOverflow.ellipsis)),
            ],
          ),
          const Divider(color: Colors.grey, thickness: 0.5, height: 5),
        ],
      ),
    );
  }
}
