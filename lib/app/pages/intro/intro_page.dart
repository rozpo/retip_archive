import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:retip/app/pages/home/home_page.dart';
import 'package:retip/app/pages/intro/bloc/intro_bloc.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IntroBloc()..add(IntroCheckPermissionEvent()),
      child: Scaffold(
        body: BlocListener<IntroBloc, IntroState>(
          listener: (context, state) {
            if (state is IntroGoToHomeState) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return const HomePage();
                  },
                ),
              );
            }
          },
          child: const _IntroWidget(),
        ),
      ),
    );
  }
}

class _IntroWidget extends StatelessWidget {
  const _IntroWidget();

  @override
  Widget build(BuildContext context) {
    const logoType = kDebugMode ? 'debug' : 'release';
    const logoPath = 'assets/$logoType/images/logo.svg';
    final bloc = context.read<IntroBloc>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox.square(
          dimension: MediaQuery.of(context).size.width / 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(150),
            child: SvgPicture.asset(logoPath),
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
          onPressed: () => bloc.add(IntroOpenAppSettingsEvent()),
          child: Text(RetipL10n.of(context).openAppSettings),
        ),
        FilledButton(
          onPressed: () => bloc.add(IntroAskPermissionEvent()),
          child: Text(
            RetipL10n.of(context).allow.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
