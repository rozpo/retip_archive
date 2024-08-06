import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    const logoType = kDebugMode ? 'debug' : 'release';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: MediaQuery.of(context).size.width / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: SvgPicture.asset('assets/$logoType/images/logo.svg'),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              RetipL10n.of(context).storageAccess,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 16),
            Text(
              RetipL10n.of(context).grantPermissionMsg,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: null,
              child: Text(RetipL10n.of(context).openAppSettings),
            ),
            FilledButton(
              onPressed: null,
              child: Text(
                RetipL10n.of(context).allow.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
