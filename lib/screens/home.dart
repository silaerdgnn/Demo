import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/setting.dart';
import 'package:flutter_news_app/theme/constants.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Haberler",
          style: TextStyle(
              color: kTextColorDark,
              fontSize: 30,
              fontFamily: "Sarabun",
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            splashRadius: 25,
            icon: Icon(
              Icons.settings,
              color: kIcons,
              size: 40,
            ),
            onPressed: () {
              Navigator.of(context).push(
                _iconAnimate(this, Settings()),
              );
            },
          )
        ],
      ),
      body: HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  HomeBody() : super();

  final String title = 'Haberler';
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  static const String url = 'https://t24.com.tr/rss';
  RssFeed _feed;
  String _title;
  GlobalKey<RefreshIndicatorState> _refresh;

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  Future<void> openBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: true);
      return;
    }
    updateTitle('Bir hata oluştu.');
  }

  load() async {
    updateTitle('Yükleniyor...');
    loadFeed().then((value) {
      if (value == null || value.toString().isEmpty) {
        updateTitle('Hata!');
        return;
      }
      updateFeed(value);
      updateTitle(_feed.title);
    });
  }

  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(url);
      return RssFeed.parse(response.body);
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    _refresh = GlobalKey<RefreshIndicatorState>();
    updateTitle(widget.title);
    load();
  }

  isEmpty() {
    return _feed == null || _feed.items == null;
  }

  @override
  Widget build(BuildContext context) {
    return isEmpty()
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            key: _refresh,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _feed.items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _feed.items[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    height: 310,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  item.enclosure.url),
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: InkWell(
                            onTap: () {
                              openBrowser(item.link);
                            },
                            child: Text(
                              item.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sarabun'),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                  "${item.pubDate.day}.${item.pubDate.month}.${item.pubDate.year}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: IconButton(
                                icon: Icon(Icons.share_sharp),
                                onPressed: () {
                                  Share.share("${item.title} ${item.link}");
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: kIcons,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: kPrimaryColor.withOpacity(0.8),
                            offset: Offset(4, 4),
                            blurRadius: 4,
                          )
                        ]),
                  ),
                );
              },
            ),
            onRefresh: () => load());
  }
}

Route _iconAnimate(Widget exit, Widget enter) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => enter,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        Stack(
      children: [
        SlideTransition(
          position:
              Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-1.0, 0.0))
                  .animate(animation),
          child: exit,
        ),
        SlideTransition(
          position:
              Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                  .animate(animation),
          child: enter,
        ),
      ],
    ),
  );
}
