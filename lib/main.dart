import 'package:flutter/material.dart';
import 'package:flutter_trip/navigator/tab_navigator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

//高级功能列表下拉刷新与上拉加载更多功能实现
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> city_name = [
    "北京",
    "上海",
    "广州",
    "深圳",
    "新疆",
    "哈尔滨",
    "天津",
    "武汉",
    "珠海"
  ];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('高级功能列表下拉刷新与上拉加载更多功能实现'),
        ),
        body: RefreshIndicator(
          onRefresh: _handlerRefresh,
          child: ListView(
            controller: _scrollController,
            children: _buildList(),
          ),
        ),
      ),
    );
  }

  loadData() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      List<String> list = List<String>.from(city_name);
      list.addAll(city_name);
      city_name = list;
    });
  }

  List<Widget> _buildList() {
    return city_name.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      alignment: Alignment.center,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.lightBlue),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  Future<void> _handlerRefresh() async {
    await Future.delayed(Duration(milliseconds: 2000));
    setState(() {
      city_name = city_name.reversed.toList();
    });
  }
}

//基于GridView实现网格布局
// const CITY_NAME = ["北京", "上海", "广州", "深圳", "新疆", "哈尔滨", "天津", "武汉", "珠海"];
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('基于GridView实现网格布局'),),
//         body: GridView.count(
//           crossAxisCount: 2, children: _buildList(),),
//       ),
//     );
//   }
//
//   List<Widget> _buildList() {
//     return CITY_NAME.map((city) => _item(city)).toList();
//   }
//
//   Widget _item(String city) {
//     return Container(
//       height: 80,
//       alignment: Alignment.center,
//       margin: EdgeInsets.all(5),
//       decoration: BoxDecoration(color: Colors.lightBlue),
//       child: Text(city, style: TextStyle(color: Colors.white, fontSize: 20),),
//     );
//   }
// }

//基于ExpansionTile实现可展开的列表
// const CITY_NAME = {
//   '北京': ['东城区', '西城区', '朝阳区', '丰台区'],
//   '深圳': ['南山区', '福田区', '罗湖区', '宝安区', '龙岗区'],
//   '广州': ['越秀区', '海珠区', '荔湾区']
// };
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('基于ExpansionTile实现可展开的列表'),
//         ),
//         body: ListView(
//           children: _buildList(),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildList() {
//     List<Widget> widget = [];
//     CITY_NAME.keys.forEach((key) {
//       widget.add(_item(key, CITY_NAME[key]));
//     });
//     return widget;
//   }
//
//   Widget _item(String city, List<String> subCities) {
//     return ExpansionTile(
//         title: Text(
//           city,
//           style: TextStyle(color: Colors.black45, fontSize: 20),
//         ),
//         children:
//         subCities.map((subCity) => _buildSub(subCity)).toList(),
//
//     );
//   }
//
//   Widget _buildSub(String subCity) {
//     return FractionallySizedBox(
//       widthFactor: 1,
//       child: Container(
//         height: 50,
//         margin: EdgeInsets.only(bottom: 5),
//         decoration: BoxDecoration(color: Colors.lightBlue),
//         child: Text(subCity),
//       ),
//     );
//   }
// }

// 基于ListView实现水平和垂直方式滚动的列表
// const CITY_NAME = ["北京", "上海", "广州", "深圳", "新疆", "哈尔滨", "天津", "武汉", "珠海"];
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('List的基本使用'),
//         ),
//         body: ListView(
//           scrollDirection: Axis.vertical,
//           children: _buildList(),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildList() {
//     return CITY_NAME.map((city) => _item(city)).toList();
//   }
//   Widget _item(city){
//     return Container(
//       height: 80,
//       margin: EdgeInsets.only(bottom: 5),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(color: Colors.teal),
//       child: Text(city,style: TextStyle(color: Colors.white,fontSize: 20),),
//     );
//   }
// }

//简单的share_preferences的使用
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   String _countString = "";
//   String _localString = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: Scaffold(
//       appBar: AppBar(
//         title: Text('share_preferences'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: _incrementCounter,
//             child: Text('Increment Counter'),
//           ),
//           ElevatedButton(
//             onPressed: _getCounter,
//             child: Text('get Counter'),
//           ),
//           Text(
//             _countString,
//             style: TextStyle(fontSize: 12),
//           ),
//           Text(
//             _localString,
//             style: TextStyle(fontSize: 12),
//           ),
//         ],
//       ),
//     ),);
//   }
//
//   _incrementCounter() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     setState(() {
//       _countString = _countString + "1";
//     });
//
//     int counter = (sharedPreferences.getInt("counter") ?? 0) + 1;
//     await sharedPreferences.setInt("counter", counter);
//   }
//
//   _getCounter() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     setState(() {
//       _localString = sharedPreferences.get("counter").toString();
//     });
//   }
// }

//FutureBuilder的使用
// class _MyAppState extends State<MyApp> {
//   String _showResult = "";
//
//   Future<CommonModel> fetchPost() async {
//     var url = Uri.parse(
//         'http://www.devio.org/io/flutter_app/json/test_common_model.json');
//     final response = await http.get(url);
//     //fix 中文乱码
//     Utf8Decoder utf8decoder = Utf8Decoder();
//     final result = json.decode(utf8decoder.convert(response.bodyBytes));
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
//         body: FutureBuilder<CommonModel>(
//             future: fetchPost(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
//               switch (snapshot.connectionState) {
//                 case ConnectionState.none:
//                   return Text('Input a URL to start');
//                 case ConnectionState.waiting:
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 case ConnectionState.active:
//                   return Text('');
//                 case ConnectionState.done:
//                   if (snapshot.hasError) {
//                     return Text(
//                       '${snapshot.error}',
//                       style: TextStyle(color: Colors.red),
//                     );
//                   } else {
//                     return Column(
//                       children: [
//                         Text('icon : ${snapshot.data.icon}'),
//                         Text('title : ${snapshot.data.title}'),
//                         Text('url : ${snapshot.data.url}'),
//                         Text(
//                             'statusBarColor : ${snapshot.data.statusBarColor}'),
//                         Text('hideAppBar : ${snapshot.data.hideAppBar}'),
//                       ],
//                     );
//                   }
//               }
//               return Text('');
//             }),
//       ),
//     );
//   }
// }

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

//Future的使用
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
