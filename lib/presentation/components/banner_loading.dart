import 'package:flutter/material.dart';

class BannerLoading extends StatelessWidget {
  const BannerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(color: Colors.grey),
    );
  }
}
