import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;

  const AppNetworkImage(
    this.url, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 256,
      height: 256,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Image.network(
        url,
        errorBuilder: (_, __, ___) => Container(
          width: double.maxFinite,
          height: 150,
          color: Colors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Center(
            child: Text(
              'Произошла ошибка при получении tile',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        loadingBuilder: (_, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
