import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowcaseviewServices {
  void checkFirstLaunchForDashboard(
    BuildContext context,
    GlobalKey _one,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final hasShown = prefs.getBool('shownDashboardTutorial') ?? false;

    if (!hasShown) {
      ShowCaseWidget.of(context).startShowCase([_one]);
      await prefs.setBool('shownDashboardTutorial', true);
    }
  }

  void checkFirstLaunchForConnectMoellim(
    BuildContext context,
    GlobalKey _one,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final hasShown = prefs.getBool('shownConnectMoellimTutorial') ?? false;

    if (!hasShown) {
      ShowCaseWidget.of(context).startShowCase([_one]);
      await prefs.setBool('shownConnectMoellimTutorial', true);
    }
  }
}
