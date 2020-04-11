//import 'package:banner_view/banner_view.dart';
import 'dart:async';
import 'dart:collection';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './banner.dart' as cBanner;
import '../../utils/custom_cursor.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = 0;
  var top = 0.0;
  var height = 0.0;
  var width = 0.0;
  bool isFirstTime = true;
  Timer _timer;
  int _start = 0;
  int currentImageIndex = 0;
  bool visibleImage = true;
  bool isScroll = false;
  double heightContainer = 150;
  double newAspectRatioHeight = 0.0;

  Color homeTextColor = Colors.white;
  Color teamTextColor = Colors.white;
  Color productsTextColor = Colors.white;
  Color aboutUsTextColor = Colors.white;
  Color newsTextColor = Colors.white;
  Color contactUsTextColor = Colors.white;
  ScrollController _scrollController;
  int rowCount = 3;

  final List<String> imgList = [
    "http://vasfa.ir/wp-content/themes/sydney/images/1.jpg",
    "http://vasfa.ir/wp-content/themes/sydney/images/2.jpg",
  ];

  final List<String> serviceTitles = [
    "پشتیبانی 24 ساعته",
    "سرویس های صوتی و چند رسانه ای",
    "توسعه محصول",
    "",
  ];
  final List<String> serviceContent = [
    "ما در وسفا معتقدیم پشتیبانی از یک محصول اگر از فرایند تولید آن مهم‌تر نباشد، قطعا به اندازه ی تولید اهمیت دارد. محصولی محبوب و فراگیر خواهد بود که پشتیبان قوی داشته باشد. تیم پشتیبانی وسفا هفت روز هفته و به صورت شبانه روزی (24ساعته) تمامی محصولات خود را پشتیبانی نموده و همواره سلامت عملکرد سرویس های خود را پایش می کند. همچنین همکاران و مشترکان می توانند از طریق ایمیل support@vasfa.ir نیز ایرادات احتمالی را به تیم گزارش نمایند یا با تلفن های شرکت تماس بگیرند",
    "یکی از پر مخاطب ترین محتواهایی که امروزه در حوزه سرویسهای ارزش افزوده (VAS) مورد توجه واقع شده، محتواهای مالتی‌مدیا (چند رسانه‌ای) می‌باشد. شرکت وسفاسیارهوشمند با کادر فنی و تامین محتوای مجرب خود، خدماتی از قبیل سرویس‌های مشاوره، فرهنگی، آموزشی، اطلاع رسانی، مذهبی و … را به صورت مالتی‌مدیا (چندرسانه‌ای) و صوتی بر بستر سرویس‌های ارزش افزوده ارائه می‌دهد. جهت اطلاعات بیشتر با کارشناسان ما تماس بگیرید",
    "گر ایده جدیدی در ذهن دارید یا محصولی دارید که میخواهید درآمدی چندین و چند برابری داشته باشد، می توانید روی تیم وسفا حساب کنید. ما با تیم توانمند خود در حوزه طراحی تجربه کاربری (UX) و رابط کاربری (UI) ، تامین محتوا و بازاریابی، ایده یا محصول شما را برای رسیدن به درآمدی بهینه و مطلوب همراهی می کنیم. همین الان با ما تماس بگیرید:",
    "",
  ];

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          _start = _start + 1;
          if (_start % 10 == 0) {
            setState(() {
              visibleImage = false;
            });
          }

          if (_start % 10 == 0) {
            Future.delayed(const Duration(milliseconds: 250), () {
              setState(() {
                currentImageIndex++;
                if (imgList.length == currentImageIndex) currentImageIndex = 0;
                visibleImage = true;
              });
            });
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = new ScrollController();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (isFirstTime) {
      isFirstTime = false;
      height = MediaQuery.of(context).size.height;
      width = MediaQuery.of(context).size.width;
      newAspectRatioHeight = (1275 / 1920) * width;
      width < 500 ? rowCount = 1 : width < 1100 ? rowCount = 2 : rowCount = 3;
      startTimer();
    }
  }

  void scrollTo() {
    var currentH = width > 1100 ? height - 120 : newAspectRatioHeight;
    _scrollController.animateTo(currentH,
        duration: new Duration(milliseconds: 1500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: width < 700
          ? Drawer(
              child: Container(
                child: Text("The Drawer!!"),
              ),
            )
          : null,
      appBar: width < 700 ? AppBar() : null,
      body: NotificationListener(
        // ignore: missing_return
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            if (width > 700) {
              setState(() {
                top -= notification.scrollDelta / 5;
                if (top > -3.0) {
                  isScroll = false;
                  heightContainer = 150;
                } else {
                  isScroll = true;
                  heightContainer = 120;
                }
              });
            }
          }
        },
        child: Stack(
          children: <Widget>[
            width > 100 ? mainBanner() : Container(),
            mainContentCustomScrollView(),
            width > 700 ? header() : Container(),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 300,
      ),
      width: double.infinity,
      height: heightContainer,
      color: isScroll ? Colors.black : Colors.transparent,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 3 / 2,
              child: Image.network(
                "http://vasfa.ir/wp-content/uploads/2020/03/Vasfa-Logo.png",
              ),
            ),
            SizedBox(
              width: width > 1100 ? 200 : 100,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CustomCursor(
                    cursorStyle: CustomCursor.pointer,
                    child: MouseRegion(
                      onHover: (event) {
                        setState(() {
                          contactUsTextColor = Colors.orange;
                        });
                      },
                      onExit: (event) {
                        setState(() {
                          contactUsTextColor = Colors.white;
                        });
                      },
                      child: Text(
                        "تماس با ما",
                        style: TextStyle(
                          color: contactUsTextColor,
                          fontFamily: "IRANSans",
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CustomCursor(
                    cursorStyle: CustomCursor.pointer,
                    child: MouseRegion(
                      onHover: (event) {
                        setState(() {
                          newsTextColor = Colors.orange;
                        });
                      },
                      onExit: (event) {
                        setState(() {
                          newsTextColor = Colors.white;
                        });
                      },
                      child: Text(
                        "اخبار",
                        style: TextStyle(
                          color: newsTextColor,
                          fontFamily: "IRANSans",
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CustomCursor(
                    cursorStyle: CustomCursor.pointer,
                    child: MouseRegion(
                      onHover: (event) {
                        setState(() {
                          aboutUsTextColor = Colors.orange;
                        });
                      },
                      onExit: (event) {
                        setState(() {
                          aboutUsTextColor = Colors.white;
                        });
                      },
                      child: Text(
                        "درباره ما",
                        style: TextStyle(
                          color: aboutUsTextColor,
                          fontFamily: "IRANSans",
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CustomCursor(
                    cursorStyle: CustomCursor.pointer,
                    child: MouseRegion(
                      onHover: (event) {
                        setState(() {
                          productsTextColor = Colors.orange;
                        });
                      },
                      onExit: (event) {
                        setState(() {
                          productsTextColor = Colors.white;
                        });
                      },
                      child: Text(
                        "نمونه‌کارها",
                        style: TextStyle(
                          color: productsTextColor,
                          fontFamily: "IRANSans",
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CustomCursor(
                    cursorStyle: CustomCursor.pointer,
                    child: MouseRegion(
                      onHover: (event) {
                        setState(() {
                          teamTextColor = Colors.orange;
                        });
                      },
                      onExit: (event) {
                        setState(() {
                          teamTextColor = Colors.white;
                        });
                      },
                      child: Text(
                        "اعضای تیم",
                        style: TextStyle(
                          color: teamTextColor,
                          fontFamily: "IRANSans",
                        ),
                      ),
                    ),
                  ),
                ),
                CustomCursor(
                  cursorStyle: CustomCursor.pointer,
                  child: MouseRegion(
                    onHover: (event) {
                      setState(() {
                        homeTextColor = Colors.orange;
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        homeTextColor = Colors.white;
                      });
                    },
                    child: Text(
                      "خانه",
                      style: TextStyle(
                        color: homeTextColor,
                        fontFamily: "IRANSans",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget mainBanner() {
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: width > 1100 ? height : newAspectRatioHeight),
        child: AnimatedOpacity(
          opacity: visibleImage ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Image.network(
            imgList[currentImageIndex],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget mainContentCustomScrollView() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              width < 100
                  ? Container()
                  : Center(
                      child: Container(
                        height: width > 1100 ? height : newAspectRatioHeight,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Center(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "به وب سایت وسفا خوش آمدید!",
                                    style: TextStyle(
                                        fontSize: width < 700 ? 15 : 35,
                                        fontFamily: "IRANSans",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                width < 100
                                    ? Container()
                                    : CustomCursor(
                                        cursorStyle: CustomCursor.pointer,
                                        child: RaisedButton(
                                          onPressed: () {
                                            scrollTo();
                                          },
                                          child: Text(
                                            "کلیک کنید",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "IRANSans",
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          color: Color(0xFFd65050),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: rowCount,
              childAspectRatio: width > 700 ? 3 / 3 : 3 / 2.5,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                color: Colors.white,
                margin: EdgeInsets.all(0),
                child: singleServices(
                  serviceTitles[index],
                  serviceContent[index],
                  index,
                ),
              );
            },
            childCount: width < 500
                ? serviceTitles.length - 1
                : width > 1100
                    ? serviceTitles.length - 1
                    : serviceTitles.length,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Center(
                child: Container(
                  height: height - heightContainer,
                  width: double.infinity,
                  color: Colors.green,
                ),
              ),
              Center(
                child: Container(
                  height: height - heightContainer,
                  width: double.infinity,
                  color: Colors.pink,
                ),
              ),
              Center(
                child: Container(
                  height: height - heightContainer,
                  width: double.infinity,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ),
      ],
      controller: _scrollController,
    );
  }

  Widget singleServices(String title, String content, int index) {
    return Container(
      padding: EdgeInsets.only(
        right: 20,
        left: 20,
        top: 20,
        bottom: 20,
      ),
//      color: index % 2 == 0 ? Colors.orange : Colors.pink,
      margin: EdgeInsets.only(right: 20, left: 20),
      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          title.trim() == ""
              ? Container()
              : Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      100.0,
                    ),
                    border: Border.all(
                      color: Colors.redAccent,
                    ),
                  ),
                  child: Icon(
                    index == 0
                        ? Icons.call
                        : index == 1
                            ? Icons.local_laundry_service
                            : Icons.lightbulb_outline,
                    color: Colors.redAccent,
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 15,
                fontFamily: "IRANSans",
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              content,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: width < 700 ? 11 : width < 1100 ? 13 : 14,
                fontFamily: "IRANSans",
                fontWeight: FontWeight.normal,
                color: Colors.black45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}