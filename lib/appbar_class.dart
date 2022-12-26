import 'package:connector_openapi/api.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/connections/statistics_singleton.dart';
import 'package:runtime_client/particle.dart';
import 'package:flutter/services.dart';

import 'tabBar_appbar.dart';

class CutomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CutomAppBar({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textFieldController = TextEditingController();
    Future<Context> connect() async {
      try {
        return connectorApi.connect(
          seededConnectorConnection: SeededConnectorConnection(
            application: SeededTrackedApplication(
              name: ApplicationNameEnum.ULTRA_EDIT,
              platform: PlatformEnum.MACOS,
              version: '1.5.8',
            ),
          ),
        );
        // print('======== $connect');
      } catch (err) {
        throw Exception('Error occurred when establishing connection. error:$err');
      }
    }
    return AppBar(
      toolbarHeight: 40,
      leadingWidth: 150,
      title: Text(title),
      leading: Row(
        children: [
//           FloatingActionButton(
//             tooltip: 'copy your snippet classifications',
//             elevation: 0,
//             mini: true,
//             backgroundColor: Colors.transparent,
//             child: Icon(
//               Icons.copy,
//               color: Colors.white,
//               size: 15,
//             ),
//             onPressed: () async {
//               ClipboardData data = ClipboardData(text: '''
// Snippet Counts by Origin:
// ${StatisticsSingleton().statistics?.classifications}
//
// ''');
//               const snackBar = SnackBar(
//                 content: Text(
//                   'Successfully copied Snippet Classifications!',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               );
//
// // Find the ScaffoldMessenger in the widget tree
// // and use it to show a SnackBar.
//               ScaffoldMessenger.of(context).showSnackBar(snackBar);
//               await Clipboard.setData(data);
//             },
//           ),
          FloatingActionButton(
            focusColor: Colors.green,
            tooltip: 'create a snippet',
            hoverColor: Colors.grey,
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.add_box_outlined,
              size: 16,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.grey,
                    title: Text(
                      'Create a Custom Snippet:',
                      style: ParticleFont.subtitle1(
                        context,
                        customization: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    content: Column(
                      children: [

                        Container(
                          color: Colors.white,
                          height: 250,
                          width: 450,
                          child: TextField(
                            autofocus: true,
                            style: ParticleFont.micro(context,
                                customization: TextStyle(color: Colors.black,fontSize: 14)),
                            toolbarOptions: ToolbarOptions(
                              copy: true,
                              paste: true,
                              selectAll: true,
                            ),
                            cursorHeight: 12,
                            cursorColor: Colors.black,
                            minLines: 20,
                            maxLines: 20,
                            autocorrect: true,
                            controller: _textFieldController,
                            decoration: InputDecoration(
                              labelStyle: ParticleFont.micro(context, customization: TextStyle(color: Colors.black, fontSize: 16),),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelText: 'Type something...',

                              hintStyle: ParticleFont.micro(context, customization: TextStyle(color: Colors.black)),
                              suffixIcon: Column(
                                children: [

                                  IconButton(
                                    iconSize: 15,
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      _textFieldController.clear();
                                    },
                                  ),
                                ],
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            color: Colors.black54,
                            child: TextButton(
                              child: Text(
                                'save to pieces',
                                style:  ParticleFont.micro(context, customization: TextStyle(color: Colors.white, fontSize: 12),),                                ),
                              onPressed: () async {
                                Context connection = await connect();

                                String create = await connectorApi.create(
                                  connection.application.id,
                                  seededConnectorCreation: SeededConnectorCreation(
                                    asset: SeededConnectorAsset(
                                      metadata: SeededAssetMetadata(
                                        description: 'SNIPPET FROM EXPEDITION',
                                        name: 'PIECES EXPEDITION',
                                        mechanism: MechanismEnum.MANUAL,
                                      ),
                                      format: SeededFormat(
                                        websites: [
                                        ],
                                        fragment: SeededFragment(
                                          metadata: FragmentMetadata(
                                              ext: ClassificationSpecificEnum.dart),
                                          string: TransferableString(
                                            raw: _textFieldController.text,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );

                                Navigator.of(context).pop();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      'Saved',
                                      style: ParticleFont.micro(context,
                                          customization: TextStyle(
                                            color: Colors.green,
                                          )),
                                    ),
                                    duration: Duration(
                                        days: 0,
                                        hours: 0,
                                        minutes: 0,
                                        seconds: 1,
                                        milliseconds: 30,
                                        microseconds: 10),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              color: Colors.black54,
                              child: TextButton(
                                child: Text(
                                  'close',
                                  style:  ParticleFont.micro(context, customization: TextStyle(color: Colors.white, fontSize: 12),),                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.black87,
    );// AppBar
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
