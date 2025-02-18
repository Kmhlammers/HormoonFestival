import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hormoon_festival/main.dart';
import 'package:confetti/confetti.dart';

class HormonenQuizScreen extends StatefulWidget {
  @override
  State<HormonenQuizScreen> createState() => _HormonenQuizScreenState();
}

class _HormonenQuizScreenState extends State<HormonenQuizScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Stack(
      children: [
        Scaffold(
          body: Stack(
            children:[
              // Main content
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                      child: Center(
                        child: Column(
                          
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 45,),
                            Text(
                              'WELK HORMOON\nDAALT HET MEEST\nTIJDENS DE\nOVERGANG?',
                              style: theme.textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                            
                            SizedBox(height: 24),
                            
                            // Answer buttons in 2x2 grid
                            Row(
                              children: [
                                Expanded(child: _buildAnswerButton(context, 'A', 'OESTROGEEN')),
                                SizedBox(width: 16),
                                Expanded(child: _buildAnswerButton(context, 'B', 'TESTOSTERON')),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(child: _buildAnswerButton(context, 'C', 'DOPAMINE')),
                                SizedBox(width: 16),
                                Expanded(child: _buildAnswerButton(context, 'D', 'TESTOSTERON')),
                              ],
                            ),
                            
                            SizedBox(height: 32),
                            
                            // Answer explanation
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'A',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      color: theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Oestrogeen daalt het meest en beïnvloedt je huid, botten en stemming.',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Back button
              Positioned(
                top: 16,
                left: 16,
                child: ElevatedButton(
                  onPressed: () => context.go('/festival/hormonen'),
                  child: Text('KAART'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Confetti overlay
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 2, // straight up
            maxBlastForce: 5,
            minBlastForce: 2,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
            gravity: 0.1,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerButton(BuildContext context, String letter, String answer) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            if (letter == 'A') {
              _confettiController.play();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.primary,
            padding: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                color: theme.colorScheme.onPrimary,
                width: 2.0,
              ),
            ),
          ),
          child: Center(
                  child: Text(
                    letter,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                    ),
                  ),
                ),
        ),
        SizedBox(height: 8),
        Text(
                answer,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
      ],
    );
  }
} 