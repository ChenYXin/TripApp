import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'dart:convert';

import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:flutter_trip/widget/webview.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List _imageUrls = [
  //   'https://dimg04.c-ctrip.com/images/0zg64120008g0rjlc78A2.jpg',
  //   'https://dimg04.c-ctrip.com/images/0zg4f120008l2ioikFE6F.jpg',
  //   'https://dimg04.c-ctrip.com/images/0zg4612000852nrt0CDAE.jpg',
  //   'https://dimg04.c-ctrip.com/images/0zg2j120008fxpweqEE0D.jpg',
  // ];

  String _resultString = "";
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    print('initState');
    _handleRefresh();
  }

  Future<Null> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        salesBoxModel = model.salesBox;
        bannerList = model.bannerList;
        _loading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        _loading = false;
      });
    }
    return null;
  }

  //第二种方式
  // loadData() async {
  //   // try {
  //   HomeModel model = await HomeDao.fetch();
  //   setState(() {
  //     _resultString = json.encode(model.config);
  //   });
  // } catch (e) {
  //   setState(() {
  //     _resultString = e.toString();
  //   });
  // }
  // }

  //第一种方式
  // loadData() {
  //   HomeDao.fetch()
  //       .then((value) => setState(() {
  //             _resultString = json.encode(value);
  //           }))
  //       .catchError((e) => {
  //             setState(() {
  //               _resultString = e.toString();
  //             })
  //           });
  // }

  void _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      _appBarAlpha = alpha;
    });
    print(_appBarAlpha);
  }

  double _appBarAlpha = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: [
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: RefreshIndicator(
                child: NotificationListener(
                  onNotification: (scrollNotification) {
                    //ScrollUpdateNotification:滚动中
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      //滚动且是列表滚动的时候
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                    return true;
                  },
                  child: _listView(),
                ),
                onRefresh: _handleRefresh,
              ),
            ),
            _appBar(),
          ],
        ),
      ),
    );
  }

  Opacity _appBar() {
    return Opacity(
            opacity: _appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          );
  }

  ListView _listView() {
    return ListView(
                  children: [
                    _banner(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                      child: LocalNav(localNavList: localNavList),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                      child: GridNav(
                        gridNavModel: gridNavModel,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                      child: SubNav(
                        subNavList: subNavList,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                      child: SalesBox(
                        salesBox: salesBoxModel,
                      ),
                    ),

                    // Container(
                    //   height: 800,
                    //   child: ListTile(
                    //     title: Text(_resultString),
                    //   ),
                    // ),
                  ],
                );
  }

  Container _banner() {
    return Container(
                    height: 160,
                    child: Swiper(
                      itemCount: bannerList.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  CommonModel model = bannerList[index];
                                  return WebView(
                                    url: model.url,
                                    title: model.title,
                                    hideAppBar: model.hideAppBar,
                                  );
                                },
                              ),
                            );
                          },
                          child: Image.network(
                            bannerList[index].icon,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                      //指示器，即小圆点
                      pagination: SwiperPagination(),
                    ),
                  );
  }
}
