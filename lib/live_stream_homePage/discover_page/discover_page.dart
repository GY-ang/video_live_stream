import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_live_stream/live_stream_homePage/discover_page/discover_permission.dart';

class NearbyAnchor {
  final String name;
  final String coverUrl;
  final bool isAule;
  final double distance;
  NearbyAnchor({required this.name, required this.coverUrl, this.isAule = true, required this.distance});
}

class VideoDiscoverPage extends StatelessWidget {
  const VideoDiscoverPage({super.key});
  static final List<NearbyAnchor> mockData = [
    NearbyAnchor(name: '猫咪老师', coverUrl: 'assets/image/001.jpeg', distance: 0.5), //
    NearbyAnchor(name: '隔壁老王', coverUrl: 'assets/image/002.png', distance: 1.2),
    NearbyAnchor(name: '小猫酱', coverUrl: 'assets/image/003.png', distance: 2.5), //
    NearbyAnchor(name: '健身达人', coverUrl: 'assets/image/004.jpeg', distance: 4.8),
    NearbyAnchor(name: '鱼王', coverUrl: 'assets/image/005.jpeg', distance: 9.1),
    NearbyAnchor(name: '美妙味道', coverUrl: 'assets/image/006.png', distance: 22.7),
    NearbyAnchor(name: '健身', coverUrl: 'assets/image/007.jpeg', distance: 66.9),
    NearbyAnchor(name: '呆萌', coverUrl: 'assets/image/008.jpeg', distance: 55.7),
    NearbyAnchor(name: '可爱', coverUrl: 'assets/image/009.jpeg', distance: 11.6),
  ];

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return ChangeNotifierProvider(
      create: (_) => AnchorProvider()..initData(),
      child: Scaffold(
        body: Consumer<AnchorProvider>(
          builder: (context, provider, child) {
            // 处理加载状态
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            //处理错误
            if (provider.error != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('错误：${provider.error}'),
                  ElevatedButton(onPressed: () => provider.initData(), child: const Text('重试')),
                ],
              );
            }
            return GridView.builder(
              padding: EdgeInsets.fromLTRB(10, 0, 10, bottomPadding + 5),
              itemCount: provider.anchors.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.8),
              itemBuilder: (context, index) => _AnchorCard(anchor: provider.anchors[index]),
            );
          },
        ),
      ),
    );
  }
}

class _AnchorCard extends StatelessWidget {
  final NearbyAnchor anchor;
  const _AnchorCard({required this.anchor});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          //图片
          Positioned.fill(child: Image.asset(anchor.coverUrl, fit: BoxFit.cover)),
          //文字
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter, //
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                ),
              ),
            ),
          ),
          //距离
          Positioned(
            left: 8,
            bottom: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@${anchor.name}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white, size: 15),
                    Text('${anchor.distance}km', style: const TextStyle(fontSize: 15, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
