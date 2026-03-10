import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:qr_flutter/qr_flutter.dart';

final qrContentProvider = StateProvider<String>((ref) => "https://flutter.dev");

class QrGeneratorPage extends ConsumerWidget {
  const QrGeneratorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听 Provider，实现动态更新
    final qrData = ref.watch(qrContentProvider);

    return QrImageView(
      data: qrData,
      version: QrVersions.auto,
      size: 200.0,
      gapless: false,
      // ，确保中间有 Logo 时依然能秒扫
      errorCorrectionLevel: QrErrorCorrectLevel.H,
      embeddedImage: const AssetImage('assets/image/001.jpeg'),
      embeddedImageStyle: const QrEmbeddedImageStyle(size: Size(50, 50)),
      eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.black),
      dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Colors.black),
    );
  }
}
