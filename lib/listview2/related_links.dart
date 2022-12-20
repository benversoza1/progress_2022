import 'package:flutter/material.dart';
import 'package:runtime_client/particle.dart';
import 'package:url_launcher/url_launcher.dart';

import '../chart data/statistics_singleton.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

// This widget is the root
// of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "ListView.builder",
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        // home : new ListViewBuilder(), NO Need To Use Unnecessary New Keyword
        home: RelatedLinksWidget());
  }
}

class RelatedLinksWidget extends StatelessWidget {
  RelatedLinksWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: StatisticsSingleton().statistics?.relatedLinks.length,
          itemBuilder: (BuildContext context, int index) {
            String linkUrl = '${StatisticsSingleton().statistics?.relatedLinks[index]}';


            return ListTile(
              tileColor: Colors.white,
              trailing: Icon(
                Icons.check_box_outline_blank,
                color: Colors.grey,
              ),
              title: ParticleButton(
                backgroundColor: Colors.white,
                textColor: Colors.black,
                text: linkUrl,
                onPressed: () async {
                  linkUrl = linkUrl; //Twitter's URL
                  if (await canLaunch(linkUrl)) {
                    await launch(
                      linkUrl,
                    );
                  } else {
                    throw 'Could not launch $linkUrl';
                  }
                },
              ),



              leading: Text(
                '🔗',
                style: ParticleFont.subtitle1(context),
              ),
            );
            // title: Text('Person: $index'));
          }),
    );
  }
}
