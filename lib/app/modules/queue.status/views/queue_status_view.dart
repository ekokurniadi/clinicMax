import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/queue_status_controller.dart';

class QueueStatusView extends GetView<QueueStatusController> {
  const QueueStatusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QueueStatusView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'QueueStatusView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
