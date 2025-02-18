import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HormonenScreen extends StatelessWidget {
  final List<(String, String, String)> menuItems = const [
    ('1.', 'QUIZZ', '/festival/hormonen/quiz'),
    ('2.', 'WIST JE DAT?', '/festival/hormonen/wist-je-dat'),
    ('3.', 'BIO-IDENTIEKE\nHORMONEN STAGE', '/festival/hormonen/stage'),
    ('4.', 'EHBO', '/festival/hormonen/ehbo'),
    ('5.', 'DO\'S & DON\'TS', '/festival/hormonen/dos-and-donts'),
    ('6.', 'SUPERMARKT', '/festival/hormonen/supermarkt'),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Image.asset(
            'assets/images/HMF_plattegrond_1 (1).png',
          ),
        ),
        
        // Content overlay
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kaart button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => context.go('/festival'),
                  child: Text('KAART'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              
              Spacer(),
              
              // List of items
              Container(
                width: 200,
                margin: const EdgeInsets.only(left: 172),
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(                  
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: menuItems.map((item) => _buildMenuItem(
                    context: context,
                    leading: item.$1,
                    title: item.$2,
                    route: item.$3,
                  )).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String leading,
    required String title,
    required String route,
  }) {
    return InkWell(
      onTap: () => context.go(route),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: Text(leading),
            ),
            Expanded(
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}