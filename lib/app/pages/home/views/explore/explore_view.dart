import 'package:flutter/material.dart';
import 'package:retip/app/pages/home/widgets/retip_icon.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(RetipL10n.of(context).retipTitle),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: const Center(
        child: RetipIcon(
          size: Size.fromHeight(64),
        ),
      ),
    );
  }
}
