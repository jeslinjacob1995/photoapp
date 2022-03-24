import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/view_image_controller.dart';

class ViewImageView extends GetView<ViewImageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ViewImageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Image.network(controller.data[0]),
      ),
    );
  }
}
