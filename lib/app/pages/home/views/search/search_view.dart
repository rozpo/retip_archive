import 'package:flutter/material.dart';
import 'package:retip/app/pages/home/widgets/retip_icon.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(RetipL10n.of(context).search),
      ),
      body: const Center(
        child: RetipIcon(
          size: Size.fromHeight(64),
        ),
      ),
    );
  }
}
