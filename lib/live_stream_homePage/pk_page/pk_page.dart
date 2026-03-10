import 'package:flutter/material.dart';
import 'package:video_live_stream/tool/index.dart';
import 'package:video_live_stream/tool/onRefresh.dart';

class PkPage extends StatefulWidget {
  const PkPage({super.key});
  @override
  State<PkPage> createState() => PkPageState();
}

class PkPageState extends State<PkPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        padding: EdgeInsets.fromLTRB(0, 5, 0, Positions.topPadding(context) + 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1),
        itemCount: VideoIndex.contentsindex.length,
        itemBuilder: (context, index) {
          final item = VideoIndex.contentsindex[index];
          return _buildItem(item);
        },
      ),
    );
  }

  Widget _buildItem(Map<String, dynamic> item) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(item['icon'], fit: BoxFit.cover),
          ),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          right: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item['title'], style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 3),
              Text(item['region'], style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
