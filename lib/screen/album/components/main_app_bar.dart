import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final VoidCallback onPickImage;
  final VoidCallback onSaveImage;
  final VoidCallback onDeleteItem;

  const MainAppBar({
    super.key,
    required this.onPickImage,
    required this.onSaveImage,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: onPickImage,
            icon: const Icon(Icons.image_search_outlined),
            color: Colors.grey[700],
          ),
          IconButton(
            onPressed: onDeleteItem,
            icon: const Icon(Icons.delete_forever_outlined),
            color: Colors.grey[700],
          ),
          IconButton(
            onPressed: onSaveImage,
            icon: const Icon(Icons.save),
            color: Colors.grey[700],
          ),
        ],
      ),
    );
  }
}
