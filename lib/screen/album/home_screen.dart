import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hello_world/screen/album/components/emoticon_sticker.dart';
import 'package:hello_world/screen/album/components/footer.dart';
import 'package:hello_world/screen/album/components/main_app_bar.dart';
import 'package:hello_world/screen/album/model/sticker_model.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? _image;
  Set<StickerModel> stickers = {};
  String? selectedId;
  GlobalKey imgKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          renderBody(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MainAppBar(
              onPickImage: onPickImage,
              onSaveImage: onSaveImage,
              onDeleteItem: onDeleteItem,
            ),
          ),
          if (_image != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Footer(
                onEmotionTap: onEmoticonTap,
              ),
            ),
        ],
      ),
    );
  }

  Widget renderBody() {
    if (_image != null) {
      return RepaintBoundary(
        key: imgKey,
        child: Positioned.fill(
          child: InteractiveViewer(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.file(
                  File(_image!.path),
                  fit: BoxFit.cover,
                ),
                if (_image != null)
                  Image.file(
                    File(_image!.path),
                    fit: BoxFit.cover,
                  ),
                ...stickers.map((sticker) {
                  return Center(
                    child: EmoticonSticker(
                      key: ValueKey(sticker.id),
                      imgPath: sticker.imgPath,
                      isSelected: sticker.id == selectedId,
                      onTransform: () => onTransform(sticker.id),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      );
    }
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.grey,
        ),
        onPressed: onPickImage,
        child: const Text('Pick an image'),
      ),
    );
  }

  void onPickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void onSaveImage() async {
    RenderRepaintBoundary boundary =
        imgKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    await ImageGallerySaver.saveImage(pngBytes, quality: 100);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image saved to gallery'),
      ),
    );
  }

  void onDeleteItem() async {
    stickers = stickers.where((sticker) => sticker.id != selectedId).toSet();
    setState(() {
      selectedId = null;
    });
  }

  void onEmoticonTap(int id) {
    final sticker = StickerModel(
      id: const Uuid().v4(),
      imgPath: 'assets/img/emoticon_$id.png',
    );

    setState(() {
      stickers.add(sticker);
    });
  }

  void onTransform(String id) {
    setState(() {
      selectedId = id;
    });
  }
}
