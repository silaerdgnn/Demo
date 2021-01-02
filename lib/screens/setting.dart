import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/splashScreen.dart';
import 'package:flutter_news_app/services/aservice.dart';
import 'package:flutter_news_app/theme/constants.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  void showLicensePage({
    @required BuildContext context,
    String applicationName,
    String applicationVersion,
    Widget applicationIcon,
    String applicationLegalese,
    bool useRootNavigator = false,
  }) {
    assert(context != null);
    assert(useRootNavigator != null);
    Navigator.of(context, rootNavigator: useRootNavigator)
        .push(MaterialPageRoute<void>(
      builder: (BuildContext context) => LicensePage(
        applicationName: applicationName,
        applicationVersion: applicationVersion,
        applicationIcon: applicationIcon,
        applicationLegalese: applicationLegalese,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ayarlar",
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
                Icons.exit_to_app_sharp,
                size: 40,
              ),
              onPressed: () async {
                try {
                  await context.read<AService>().sigOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SplashScreen(),
                    ),
                  );
                } catch (e) {}
              })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sıla Türkü ERDOĞAN",
              style: TextStyle(
                  color: kPrimaryColor, fontSize: 30, fontFamily: "Sarabun"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text("versiyon: 1.0.0+1",
                  style: TextStyle(
                      color: kIcons, fontSize: 20, fontFamily: "Sarabun")),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: InkWell(
                child: Text(
                  "Lisans listesi",
                  style: TextStyle(
                      color: kTextColorLight,
                      fontSize: 20,
                      fontFamily: "Sarabun"),
                ),
                onTap: () => showLicensePage(context: context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
