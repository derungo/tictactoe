import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class ImageLoader {
  static Future<ui.Image> loadChalkboardImage() async {
    final ByteData data = await rootBundle.load('assets/chalkboard1.jpeg');
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }
}
