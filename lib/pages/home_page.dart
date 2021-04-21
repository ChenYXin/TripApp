import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'https://dimg04.c-ctrip.com/images/0zg64120008g0rjlc78A2.jpg',
    'https://dimg04.c-ctrip.com/images/0zg4f120008l2ioikFE6F.jpg',
    'https://dimg04.c-ctrip.com/images/0zg4612000852nrt0CDAE.jpg',
    'https://dimg04.c-ctrip.com/images/0zg2j120008fxpweqEE0D.jpg',
  ];

  void _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if(alpha<0){
      alpha=0;
    }else if(alpha>1){
      alpha=1;
    }
    setState(() {
      _appBarAlpha=alpha;
    });
    print(_appBarAlpha);
  }

  double _appBarAlpha = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
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
              child: ListView(
                children: [
                  Container(
                    height: 160,
                    child: Swiper(
                      itemCount: _imageUrls.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _imageUrls[index],
                          fit: BoxFit.fill,
                        );
                      },
                      //指示器，即小圆点
                      pagination: SwiperPagination(),
                    ),
                  ),
                  Container(
                    height: 800,
                    child: ListTile(
                      title: Text('Donkor'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Opacity(
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
          ),
        ],
      ),
    );
  }
}
