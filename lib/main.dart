import 'package:flutter/material.dart';
import 'package:flutter_trip/navigator/tab_navigator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _showResult = "";

  Future<CommonModel> fetchPost() async {
    var url = Uri.parse(
        'http://www.devio.org/io/flutter_app/json/test_common_model.json');
    final response = await http.get(url);
    //fix 中文乱码
    Utf8Decoder utf8decoder = Utf8Decoder();
    final result = json.decode(utf8decoder.convert(response.bodyBytes));
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Http'),
        ),
        body: FutureBuilder<CommonModel>(
            future: fetchPost(),
            builder:
                (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Input a URL to start');
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                  return Text('');
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    return Column(
                      children: [
                        Text('icon : ${snapshot.data.icon}'),
                        Text('title : ${snapshot.data.title}'),
                        Text('url : ${snapshot.data.url}'),
                        Text(
                            'statusBarColor : ${snapshot.data.statusBarColor}'),
                        Text('hideAppBar : ${snapshot.data.hideAppBar}'),
                      ],
                    );
                  }
              }
              return Text('');
            }),
      ),
    );
  }
}

class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar'],
    );
  }
}

// class _MyAppState extends State<MyApp> {
//   String _showResult = "";
//
//   Future<CommonModel> fetchPost() async {
//     var url = Uri.parse(
//         'http://www.devio.org/io/flutter_app/json/test_common_model.json');
//     final response = await http.get(url);
//     final result = json.decode(response.body);
//     return CommonModel.fromJson(result);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Http'),
//         ),
//         body: Column(
//           children: [
//             InkWell(
//               onTap: () {
//                 fetchPost().then((value) => setState(() {
//                   _showResult = "请求结果：\n icon : ${value.icon}"
//                       "\n title : ${value.title}"
//                       "\n url : ${value.url}"
//                       "\n statusBarColor : ${value.statusBarColor}"
//                       "\n hideAppBar : ${value.hideAppBar}";
//                 }));
//               },
//               child: Text(
//                 '点我',
//                 style: TextStyle(fontSize: 30),
//               ),
//             ),
//             Text(_showResult),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CommonModel {
//   final String icon;
//   final String title;
//   final String url;
//   final String statusBarColor;
//   final bool hideAppBar;
//
//   CommonModel(
//       {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});
//
//   factory CommonModel.fromJson(Map<String, dynamic> json) {
//     return CommonModel(
//       icon: json['icon'],
//       title: json['title'],
//       url: json['url'],
//       statusBarColor: json['statusBarColor'],
//       hideAppBar: json['hideAppBar'],
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: TabNavigator(),
//     );
//   }
// }
