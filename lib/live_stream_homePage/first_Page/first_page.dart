import 'package:flutter/material.dart';
import 'package:video_live_stream/tool/index.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    // 使用 MediaQuery.removePadding 彻底移除系统可能存在的顶部安全区干扰
    return MediaQuery.removePadding(
      context: context,
      removeTop: true, // 确保内容可以顶到最上方
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(padding: const EdgeInsets.fromLTRB(16, 5, 16, 8), child: Text('热门推荐')),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = VideoIndex.contentsindex[index];
                return _buildGrandLiveCard(item);
              }, childCount: VideoIndex.contentsindex.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1, crossAxisSpacing: 10, mainAxisSpacing: 10),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildGrandLiveCard(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1), //
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            //1,图片
            Image.network(item['icon'], fit: BoxFit.cover),
            //2，名字
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(item['title'], style: TextStyle(fontSize: 13), maxLines: 1),
                  const SizedBox(height: 4),
                  //地区
                  Text(item['region'], style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
      //封面区域
    );
  }
}
