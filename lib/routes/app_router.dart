import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/festival_screen.dart';
import '../screens/areas/hormonen_screen.dart';
import '../screens/areas/hormonen_areas/hormonen_quiz.dart';
import '../main.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: '/festival',
          builder: (context, state) => FestivalScreen(
            title: 'Welkom op het FESTIVAL!',
          ),
          routes: [
            GoRoute(
              path: 'hormonen',
              builder: (context, state) => HormonenScreen(),
              routes: [
                GoRoute(
                  path: 'quiz',
                  builder: (context, state) => HormonenQuizScreen(),
                ),
                // Other subroutes can be added here
              ],
            ),
            // Add more detail screen routes here
          ],
        ),
        GoRoute(
          path: '/info',
          builder: (context, state) => const InfoScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
); 