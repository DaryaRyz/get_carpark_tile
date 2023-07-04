import 'package:flutter/material.dart';
import 'package:maps/domain/models/tile_info.dart';
import 'package:maps/presentation/widgets/app_network_image.dart';

class ReadyContent extends StatelessWidget {
  final TileInfo tileInfo;

  const ReadyContent({
    Key? key,
    required this.tileInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tile'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              AppNetworkImage(tileInfo.tileUrl),
              const SizedBox(height: 16),
              Text(
                'x: ${tileInfo.x}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 12),
              Text(
                'y: ${tileInfo.y}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 12),
              Text(
                'zoom: ${tileInfo.zoom}',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
