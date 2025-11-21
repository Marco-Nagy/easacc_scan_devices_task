import 'package:easacc_scan_devices_task/core/utils/routing/app_router.dart';
import 'package:flutter/material.dart';

// lib/features/scan_devices/presentation/view/web_screen_view.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreenView extends StatefulWidget {
  static const routeName = '/web';

  final String url;

  const WebScreenView({
    super.key,
    required this.url,
  });

  @override
  State<WebScreenView> createState() => _WebScreenViewState();


}

class _WebScreenViewState extends State<WebScreenView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(AppRouter.settingsView),
        ),
        title: Text(
          widget.url,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
