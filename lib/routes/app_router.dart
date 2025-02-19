import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/festival_screen.dart';
import '../layout_screen.dart';
import '../screens/areas/hormonen_screen.dart';
import '../screens/areas/hormonen_areas/hormonen_quiz.dart';
import '../main.dart';
import '../screens/areas/hormonen_areas/wist_je_dat_hormonen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        String path = GoRouterState.of(context).uri.path;
        String title = _getTitleForRoute(path);
        OverlayImageConfig? overlayConfig = _getOverlayConfigForRoute(path);
        return LayoutScreen(
          child: child, 
          title: title,
          overlayConfig: overlayConfig,
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const WelcomeScreen(), // Directly use WelcomeScreen
        ),
        GoRoute(
          path: '/festival',
          builder: (context, state) => FestivalScreen(title: 'Welkom op het FESTIVAL!'), // Directly use FestivalScreen
          routes: [
            GoRoute(
              path: 'hormonen',
              builder: (context, state) => HormonenScreen(), // Directly use HormonenScreen
              routes: [
                GoRoute(
                  path: 'quiz',
                  builder: (context, state) => HormonenQuizScreen(), // Directly use HormonenQuizScreen
                ),
                GoRoute(
                  path: 'wist-je-dat',
                  builder: (context, state) => WistJeDatScreen(), // Directly use HormonenQuizScreen
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/info',
          builder: (context, state) => const InfoScreen(), // Directly use InfoScreen
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(), // Directly use ProfileScreen
        ),
      ],
    ),
  ],
);

String _getTitleForRoute(String path) {
  if (path.startsWith('/festival/hormonen/quiz')) {
    return 'QUIZZ';
  }
  if (path.startsWith('/festival/hormonen/wist-je-dat')) {
    return 'WIST JE DAT    ';
  }
  if (path.startsWith('/festival/hormonen')) {
    return 'Welkom op het\nHORMONEN terrein';
  }
  if (path.startsWith('/festival')) {
    return 'Welkom op het\nFESTIVAL!';
  }
  if (path.startsWith('/info')) {
    return 'Info';
  }
  if (path.startsWith('/profile')) {
    return 'Profiel';
  }
  return 'H! Elke, leuk je\nhier weer te zien!';
}

OverlayImageConfig? _getOverlayConfigForRoute(String path) {
  if (path.startsWith('/festival/hormonen/wist-je-dat')) {
    return OverlayImageConfig(
      imagePath: 'assets/images/location_symbol.png',
      right: 20,
      top: 40,
      height: 90, 
    );
  }
  return null; 
}