//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class HomeScreen extends StatelessWidget {
//   final homeUrl = 'https://hwangjeonghyeon1.github.io';
//   WebViewController? controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Hwang Leader'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 if (controller == null) {
//                   return ;
//                 }
//                 controller!.loadUrl(homeUrl);
//               },
//               icon: Icon(
//                 Icons.home
//               ))
//         ],
//       ),
//       body: WebView(
//         onWebViewCreated: (WebViewController controller) {
//           this.controller = controller;
//         },
//         initialUrl: homeUrl,
//         javascriptMode: JavascriptMode.unrestricted,
//       )
//
//     );
//
//   }
// }