import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import 'home_provider.dart';

/// banner
class HomeBanner extends StatelessWidget {
  final List<Map<String, Object>> data;

  HomeBanner(this.data);

  @override
  Widget build(BuildContext context) {
    if (data.length == 0) {
      return Container(
        margin: EdgeInsets.only(top: 5),
        height: 150,
      );
    }

    final _size = MediaQuery.of(context).size;
    // 横竖屏返回不同 widget 解决 Swiper 横竖屏切换的 bug
    if (_size.width > _size.height) {
      return _getSwiper(context);
    }
    return Container(
      child: _getSwiper(context),
    );
  }

  Widget _getSwiper(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width * 1.0;

    final fraction = (375.0 / screenWidth * 100).toInt() * 0.9 / 100;

    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 150,
      child: Consumer<HomeProvider>(builder: (context, state, child) {
        return Swiper(
          viewportFraction: fraction,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Padding(
                  padding: EdgeInsets.only(left: 6, right: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: CachedNetworkImage(
                      imageUrl: data[index]["imageUrl"],
                    ),
                  )),
            );
          },
          itemCount: data.length,
        );
      }),
    );
  }
}

/// icon 导航
class HomeQuickEntrance extends StatelessWidget {
  final List<Map<String, Object>> data;

  HomeQuickEntrance(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Flex(
        direction: Axis.horizontal,
        children: data
            .map((item) => _menuItem(item["title"], item["imageUrl"]))
            .toList(),
      ),
    );
  }

  Widget _menuItem(String title, String url) {
    return Expanded(
      flex: 1,
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            width: 60,
            height: 60,
            imageUrl: url,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              title,
              style: TextStyle(color: Color(0xff6e6e6e), fontSize: 11),
            ),
          )
        ],
      ),
    );
  }
}

/// 标题
class HomeHeader extends StatelessWidget {
  // 标题
  final Map<String, Object> data;
  HomeHeader(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
//        padding: const EdgeInsets.only(left: 12),
        height: 40,
        child: Row(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: data["imageUrl"],
              width: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                data["title"],
                style: TextStyle(
                    fontSize: 17,
                    color: Color(0xff444444),
                    fontWeight: FontWeight.bold),
              ),
            ),
            data["hasMore"]
                ? Expanded(
                    child: Container(
                    alignment: Alignment.centerRight,
                    child: Image.asset("images/main/main_more_arrow.png"),
                  ))
                : Container()
          ],
        ));
  }
}

/// 全局 banner
class HomeTinyBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
            imageUrl:
                "https://oimagec8.ydstatic.com/image?id=-6043440067699066638&product=xue"),
      ),
    );
  }
}

/// 普通书
class HomeNormalBook extends StatelessWidget {
  final List<Map> data;

  HomeNormalBook(this.data);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (screenSize.width > screenSize.height) ? 6 : 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.64),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _item(index, context);
          },
          childCount: data.length,
        ),
      ),
    );
  }

  Widget _item(int index, BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0xffeaeaea),
                  offset: Offset(0.0, 1.0),
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Stack(
                children: <Widget>[
                  Container(
//                      width: 50,
                      color: Color(0xfffbfbfb),
                      child: CachedNetworkImage(
                        useOldImageOnUrlChange: true,
                        imageUrl: data[index]["coverImageUrl"],
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      )),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: CachedNetworkImage(
                      imageUrl: data[index]["subscriptUrl"] ?? "",
                    ),
                  )
                ],
              ),
            ),
          )),
          Container(
            padding: const EdgeInsets.fromLTRB(4, 5, 4, 5),
            child: Text(
              data[index]["title"],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}

/// 高类型
class HomeHighlyRecommendedBook extends StatelessWidget {
  final List<Map<String, Object>> data;

  HomeHighlyRecommendedBook(this.data);

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 130.0,
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0xffeaeaea),
                      offset: Offset(0.0, 1.0),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Container(
                      width: 77,
                      color: Color(0xfffbfbfb),
                      child: CachedNetworkImage(
                        imageUrl: data[index]["coverImageUrl"],
                        fit: BoxFit.cover,
                        height: 106,
                      )),
                ),
              ),
              Positioned(
                top: 5,
                left: 95,
                right: 0,
                child: Text(
                  data[index]["title"],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color(0xff444444),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                top: 28,
                left: 95,
                right: 0,
                child: Text(
                  data[index]["tags"],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(color: Color(0xff9b9b9b), fontSize: 12),
                ),
              ),
              Positioned(
                top: 75,
                left: 95,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Color(0xfff8f8f8),
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    data[index]["description"],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Color(0xff979797), fontSize: 12),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 1,
                right: 1,
                child: Divider(),
              )
            ],
          ),
        );
      }, childCount: data.length),
    );
    ;
  }
}

/// 专栏
class HomeColumn extends StatelessWidget {
  final List<Map<String, Object>> data;

  HomeColumn(this.data);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SliverFixedExtentList(
      itemExtent: 140.0,
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          padding:
              const EdgeInsets.only(left: 22, right: 22, top: 5, bottom: 5),
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(imageUrl: data[index]["imageUrl"]),
              Positioned(
                left: 110,
                top: 32,
                child: Text(
                  data[index]["title"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Positioned(
                top: 60,
                left: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.from(data[index]["subItemNames"])
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(top: 2, bottom: 2),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                    "images/main/main_section_play.png"),
                                Text(
                                  item,
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 12),
                                )
                              ],
                            ),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        );
      }, childCount: data.length),
    );
  }
}

/// 从书
class HomeSeries extends StatelessWidget {
  final List<Map<String, Object>> data;

  HomeSeries(this.data);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
      sliver: SliverGrid(
        //Grid
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (screenSize.width > screenSize.height) ? 4 : 2,
            mainAxisSpacing: 18.0,
            crossAxisSpacing: 15.0,
            childAspectRatio: 1.2),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0xffeaeaea),
                      offset: Offset(0.0, 1.0),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Container(
//                      width: 100,
                      color: Color(0xfffbfbfb),
                      child: CachedNetworkImage(
                        imageUrl: data[index]["imageUrl"],
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            );
          },
          childCount: data.length,
        ),
      ),
    );
    ;
  }
}
