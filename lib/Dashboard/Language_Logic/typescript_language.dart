import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:runtime_client/particle.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../connections/statistics_singleton.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

// This widget is the root
// of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      // home : new ListViewBuilder(), NO Need To Use Unnecessary New Keyword
      // home:  LanguageBuilder());
    );
  }
}

class TypeScriptLanguageBuilder extends StatelessWidget {
  final String title;
  final String subtitle;
  final Image leading;

  TypeScriptLanguageBuilder({
    required this.title,
    required this.subtitle,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    int? count = StatisticsSingleton().statistics?.typescript.length;

    if (count == 0) {
      return Card(
        child: Column(
          children: [
            ListTile(
              leading: leading,
              title: Text(title),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Image.asset('Sad.jpg'),
              title: Text('You have 0saved snippets'),
              subtitle: Text(''),
              // trailing: Icon(Icons.copy),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: ListTile(
                // leading: Image.asset('chrome.jpg'),
                leading: TextButton(
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(text: 'Browse this collection to get started! ----', style: ParticleFont.micro(context, customization: TextStyle(color: Colors.grey)), children: <InlineSpan>[
                      TextSpan(
                        text: 'Python Collection',
                        style: ParticleFont.micro(
                          context,
                          customization: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 22
                          ),
                        ),
                      )
                    ]),
                  ),
                  onPressed: () async {
                    String linkUrl =
                        'https://code.pieces.app/collections/dart?os=C67CACB2-1171-48D6-88F4-3363FC54E34C%0A&user=db21f9b1-f7a4-45ba-82c4-5f029e9177d0';

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
                // Text('No worries, check out a Pieces Collection here!'),

                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(height: 25, child: Image.asset('chrome.jpeg')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, right: 4.0),
                        child: SizedBox(height: 25, child: Image.asset('vs_code.jpeg')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(height: 25, child: Image.asset('intellij.jpeg')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(height: 25, child: Image.asset('CLI.jpg')),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      );
    } else {
    return Container(
      color: Colors.grey,
      child: ListView.builder(
        itemCount: StatisticsSingleton().statistics?.typescript.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: [
                ListTile(
                  leading: leading,
                   title: Text(title),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  // leading: Image.asset('batchfile-black.jpg'),
                  title: Text('${StatisticsSingleton().statistics?.typescript.elementAt(index).name}' ?? ''),
                  subtitle: Text('${StatisticsSingleton().statistics?.typescript.elementAt(index).description}' ?? ''),
                  trailing: Icon(Icons.copy),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  }
}
