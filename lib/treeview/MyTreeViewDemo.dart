import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'trees/controller_usage.dart';
import 'trees/tree_from_json.dart';

class MyTreeViewDemo extends StatelessWidget {
  const MyTreeViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('flutter_simple_treeview Demo'),
            actions: [
              TextButton(
                  child: const Text(
                    "Source Code",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async => await launchUrl(
                        Uri.https('github.com',
                            'google/flutter.widgets/tree/master/packages/flutter_simple_treeview/example'),
                      )),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(text: "Tree Controller Usage"),
                Tab(text: "Tree From JSON"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              buildBodyFrame(const ControllerUsage()),
              buildBodyFrame(const TreeFromJson()),
            ],
          ),
        ),
      ),
    );
  }

  /// Adds scrolling and padding to the [content].
  Widget buildBodyFrame(Widget content) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: content,
        ),
      ),
    );
  }
}
