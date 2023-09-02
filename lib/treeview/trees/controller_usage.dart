import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

/// Demonstrates how to change state of the tree in external event handlers,
/// like button taps.
class ControllerUsage extends StatefulWidget {
  const ControllerUsage({super.key});

  @override
  _ControllerUsageState createState() => _ControllerUsageState();
}

class _ControllerUsageState extends State<ControllerUsage> {
  final Key _key = const ValueKey(22);
  final TreeController _controller = TreeController(allNodesExpanded: true);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 300,
          width: 300,
          child: buildTree(),
        ),
        ElevatedButton(
          child: const Text("Expand All"),
          onPressed: () => setState(() {
            _controller.expandAll();
          }),
        ),
        ElevatedButton(
          child: const Text("Collapse All"),
          onPressed: () => setState(() {
            _controller.collapseAll();
          }),
        ),
        ElevatedButton(
          child: const Text("Expand node 22"),
          onPressed: () => setState(() {
            _controller.expandNode(_key);
          }),
        ),
        ElevatedButton(
          child: const Text("Collapse node 22"),
          onPressed: () => setState(() {
            _controller.collapseNode(_key);
          }),
        ),
      ],
    );
  }

  Widget buildTree() {
    return TreeView(
      treeController: _controller,
      nodes: [
        TreeNode(content: const Text("node 1")),
        TreeNode(
          content: const Icon(Icons.audiotrack),
          children: [
            TreeNode(content: const Text("node 21")),
            TreeNode(
              content: const Text("node 22"),
              key: _key,
              children: [
                TreeNode(
                  content: const Icon(Icons.sentiment_very_satisfied),
                ),
              ],
            ),
            TreeNode(
              content: const Text("node 23"),
            ),
          ],
        ),
      ],
    );
  }
}
