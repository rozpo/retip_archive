import 'package:flutter/material.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(RetipL10n.of(context).settings),
      ),
      body: ListView.separated(
        itemCount: 100,
        separatorBuilder: (context, index) {
          if ((index + 1) % 10 == 0) {
            return const Divider();
          }
          return const SizedBox();
        },
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Index $index'),
          );
        },
      ),
    );
  }
}
