import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  "https://cdn.pixabay.com/photo/2017/03/07/20/45/cog-wheels-2125169_960_720.jpg",
  "https://bepors.me/peas/billboard/2.png",
  "https://bepors.me/peas/billboard/3.png",
];

class Banner extends StatefulWidget {
  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        CarouselSlider(
          autoPlay: true,
          viewportFraction: 1.0,
          autoPlayCurve: Curves.bounceIn,
//          aspectRatio: MediaQuery.of(context).size.aspectRatio,
          items: imgList.map(
            (url) {
              return Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ).toList(),
        ),
//        CarouselSlider(
//          items: child,
//          viewportFraction: 1.0,
//          aspectRatio: MediaQuery.of(context).size.aspectRatio,
//          autoPlay: true,
//          enlargeCenterPage: true,
//          onPageChanged: (index) {
//            setState(() {
//              _current = index;
//            });
//          },
//        ),
//        Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: map<Widget>(
//            imgList,
//            (index, url) {
//              return Container(
//                width: 8.0,
//                height: 8.0,
//                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
//                decoration: BoxDecoration(
//                    shape: BoxShape.circle,
//                    color: _current == index
//                        ? Color.fromRGBO(0, 0, 0, 0.9)
//                        : Color.fromRGBO(0, 0, 0, 0.4)),
//              );
//            },
//          ),
//        ),
      ]),
    );
  }
}

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

final List child = map<Widget>(
  imgList,
  (index, i) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          Image.network(i, fit: BoxFit.cover, width: 1000.0),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                'No. $index image',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  },
).toList();
