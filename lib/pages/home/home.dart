//import 'package:banner_view/banner_view.dart';
import 'dart:async';
import 'dart:collection';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './banner.dart' as cBanner;
import '../../utils/custom_cursor.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final projectsKey = new GlobalKey();

  int _current = 0;
  var top = 0.0;
  var topFakeBanner = 0.0;
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
  Color scrollTextColor = Colors.white;
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
  ];
  final List<String> serviceContent = [
    "ما در وسفا معتقدیم پشتیبانی از یک محصول اگر از فرایند تولید آن مهم‌تر نباشد، قطعا به اندازه ی تولید اهمیت دارد. محصولی محبوب و فراگیر خواهد بود که پشتیبان قوی داشته باشد. تیم پشتیبانی وسفا هفت روز هفته و به صورت شبانه روزی (24ساعته) تمامی محصولات خود را پشتیبانی نموده و همواره سلامت عملکرد سرویس های خود را پایش می کند. همچنین همکاران و مشترکان می توانند از طریق ایمیل support@vasfa.ir نیز ایرادات احتمالی را به تیم گزارش نمایند یا با تلفن های شرکت تماس بگیرند",
    "یکی از پر مخاطب ترین محتواهایی که امروزه در حوزه سرویسهای ارزش افزوده (VAS) مورد توجه واقع شده، محتواهای مالتی‌مدیا (چند رسانه‌ای) می‌باشد. شرکت وسفاسیارهوشمند با کادر فنی و تامین محتوای مجرب خود، خدماتی از قبیل سرویس‌های مشاوره، فرهنگی، آموزشی، اطلاع رسانی، مذهبی و … را به صورت مالتی‌مدیا (چندرسانه‌ای) و صوتی بر بستر سرویس‌های ارزش افزوده ارائه می‌دهد. جهت اطلاعات بیشتر با کارشناسان ما تماس بگیرید",
    "گر ایده جدیدی در ذهن دارید یا محصولی دارید که میخواهید درآمدی چندین و چند برابری داشته باشد، می توانید روی تیم وسفا حساب کنید. ما با تیم توانمند خود در حوزه طراحی تجربه کاربری (UX) و رابط کاربری (UI) ، تامین محتوا و بازاریابی، ایده یا محصول شما را برای رسیدن به درآمدی بهینه و مطلوب همراهی می کنیم. همین الان با ما تماس بگیرید:",
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
      width < 500 ? rowCount = 1 : width < 992 ? rowCount = 1 : rowCount = 3;
      startTimer();
    }
  }

  void scrollTo() {
    var currentH = width > 1100
        ? height - 120
        : width > 700 ? newAspectRatioHeight - 120 : newAspectRatioHeight;
    _scrollController.animateTo(currentH,
        duration: new Duration(milliseconds: 1500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.red,
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      drawer: width < 700
          ? Drawer(
              child: Container(
                child: Text("The Drawer!!"),
              ),
            )
          : null,
      appBar: width < 700
          ? AppBar(
              backgroundColor: Colors.redAccent,
              brightness: Brightness.dark,
            )
          : null,
      body: NotificationListener(
        // ignore: missing_return
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            if (width > 100) {
              setState(() {
                top -= notification.scrollDelta / 5;
                topFakeBanner -= notification.scrollDelta;
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
            fakeBanner(),
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
                          contactUsTextColor = Colors.redAccent;
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
                          newsTextColor = Colors.redAccent;
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
                          aboutUsTextColor = Colors.redAccent;
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
                  child: GestureDetector(
                    onTap: () => Scrollable.ensureVisible(
                      projectsKey.currentContext,
                      duration: Duration(milliseconds: 500),
                    ),
                    child: CustomCursor(
                      cursorStyle: CustomCursor.pointer,
                      child: MouseRegion(
                        onHover: (event) {
                          setState(() {
                            productsTextColor = Colors.redAccent;
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
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CustomCursor(
                    cursorStyle: CustomCursor.pointer,
                    child: MouseRegion(
                      onHover: (event) {
                        setState(() {
                          teamTextColor = Colors.redAccent;
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
                        homeTextColor = Colors.redAccent;
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

  Widget fakeBanner() {
    return Positioned(
      top: (width > 1100 ? height : newAspectRatioHeight) + topFakeBanner,
      left: 0,
      right: 0,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 10000),
        child: Container(
          color: Colors.white,
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
                                SizedBox(
                                  height: 50,
                                ),
                                width > 100
                                    ? GestureDetector(
                                        onTap: () {
                                          scrollTo();
                                        },
                                        child: CustomCursor(
                                          cursorStyle: CustomCursor.pointer,
                                          child: MouseRegion(
                                            onHover: (event) {
                                              setState(() {
                                                scrollTextColor =
                                                    Colors.redAccent;
                                              });
                                            },
                                            onExit: (event) {
                                              setState(() {
                                                scrollTextColor = Colors.white;
                                              });
                                            },
                                            child: scrollTextColor ==
                                                    Colors.redAccent
                                                ? Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        5.0,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.redAccent,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "کلیک کنید",
                                                      style: TextStyle(
                                                        color: scrollTextColor,
                                                        fontFamily: "IRANSans",
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.redAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        5.0,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.redAccent,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "کلیک کنید",
                                                      style: TextStyle(
                                                        color: scrollTextColor,
                                                        fontFamily: "IRANSans",
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      )
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
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                height: 160,
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        "سرویس های ما",
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: "IRANSans",
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 1,
                        width: 60,
                        color: Colors.redAccent,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: rowCount,
              childAspectRatio: width < 700
                  ? 1.2
                  : width < 800 ? 2.8 : width < 1100 ? 3 / 4 : 3 / 2.5,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(0),
                color: Colors.white,
                margin: EdgeInsets.all(0),
                child: singleServices(
                  serviceTitles[index],
                  serviceContent[index],
                  index,
                ),
              );
            },
            childCount: serviceTitles.length,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                width: double.infinity,
                color: Colors.white,
                margin: EdgeInsets.only(
                  bottom: 50,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: CustomCursor(
                      cursorStyle: CustomCursor.pointer,
                      child: MouseRegion(
                        onHover: (event) {
                          setState(() {
                            scrollTextColor = Colors.redAccent;
                          });
                        },
                        onExit: (event) {
                          setState(() {
                            scrollTextColor = Colors.white;
                          });
                        },
                        child: scrollTextColor == Colors.redAccent
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                    5.0,
                                  ),
                                  border: Border.all(
                                    color: Colors.redAccent,
                                  ),
                                ),
                                child: Text(
                                  "مشاهده کامل سرویس ها",
                                  style: TextStyle(
                                    color: scrollTextColor,
                                    fontFamily: "IRANSans",
                                  ),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(
                                    5.0,
                                  ),
                                  border: Border.all(
                                    color: Colors.redAccent,
                                  ),
                                ),
                                child: Text(
                                  "مشاهده کامل سرویس ها",
                                  style: TextStyle(
                                    color: scrollTextColor,
                                    fontFamily: "IRANSans",
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverList(
          key: projectsKey,
          delegate: SliverChildListDelegate(
            [
              Container(
                height: 160,
                width: double.infinity,
                color: Color(0xFFededed),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        "محیط کاری ما چگونه است؟",
                        style: TextStyle(
                            fontSize: width > 700 ? 30 : 20,
                            fontFamily: "IRANSans",
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 1,
                        width: 60,
                        color: Colors.redAccent,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        owerWorkPlace(),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Center(
                child: Container(
                  height: height - heightContainer,
                  width: double.infinity,
                  color: Colors.blueGrey,
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
                  width: 66,
                  height: 66,
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

  Widget owerWorkPlace() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: width < 780 ? 1 : 2,
        childAspectRatio: (width > 500 && width < 780) ? 2 : 1.3,
      ),
      delegate: SliverChildListDelegate(
        [
          Container(
            color: Color(0xFFededed),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Image.network(
              "http://vasfa.ir/wp-content/uploads/2020/03/priscilla-du-preez-XkKCui44iM0-unsplash-e1571049095841.jpg",
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            color: Color(0xFFededed),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: (width > 500 && width < 780) ? 6.5 : 4,
                  ),
                  delegate: SliverChildListDelegate([
                    Center(
                      child: Container(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            leading: icons(Icons.settings, 56.0, 56.0),
                            title: contents("رشد و توسعه فردی", true),
                            subtitle: contentsJustify(
                                "چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد.",
                                true),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            leading: icons(Icons.public, 56.0, 56.0),
                            title: contents("اینترنت نامحدود", true),
                            subtitle: contentsJustify(
                                "چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد.",
                                true),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            leading: icons(Icons.local_cafe, 56.0, 56.0),
                            title: contents("کافی‌شاپ رایگان", false),
                            subtitle: contentsJustify(
                                "چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد.",
                                true),
                          ),
                        ),
                      ),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget icons(IconData icon, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          100.0,
        ),
        border: Border.all(
          color: Colors.redAccent,
        ),
      ),
      child: Icon(
        icon,
        color: Colors.redAccent,
      ),
    );
  }

  Widget contents(String text, bool justify) {
    return Text(
      text,
      style: TextStyle(
        fontSize: width < 700 ? 12 : width < 1100 ? 13 : 14,
        fontFamily: "IRANSans",
        fontWeight: FontWeight.bold,
        color: Colors.black45,
      ),
    );
  }

  Widget contentsJustify(String text, bool justify) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: width < 700 ? 11 : width < 1100 ? 13 : 14,
        fontFamily: "IRANSans",
        fontWeight: FontWeight.normal,
        color: Colors.black45,
      ),
    );
  }
}
