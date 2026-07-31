/// PromptPlaygroundScreen — System Prompt Engineering Platform (Amendment 3.2D)
library;

import 'package:ai_hustle_copilot/shared/widgets/topographic_wave_header.dart';
import 'package:flutter/material.dart';

/// Playground screen for testing, versioning, and editing system prompts.
class PromptPlaygroundScreen extends StatefulWidget {
  /// Creates a [PromptPlaygroundScreen].
  const PromptPlaygroundScreen({super.key});

  @override
  State<PromptPlaygroundScreen> createState() => _PromptPlaygroundScreenState();
}

class _PromptPlaygroundScreenState extends State<PromptPlaygroundScreen> {
  final _promptController = TextEditingController(
    text: 'You are an enterprise AI Co-Pilot for {{user_name}}. Follow Clean Architecture and SOLID rules.',
  );

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          WaveHeaderWidget(
            height: 180.0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8.0),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Prompt Playground',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'System Prompt Management & Version Testing',
                          style: TextStyle(
                            color: Color(0xFF3A5FA0),
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'System Prompt Editor (v1.2 Active)',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Expanded(
                    child: TextField(
                      controller: _promptController,
                      maxLines: null,
                      expands: true,
                      style: const TextStyle(fontFamily: 'FiraCode', fontSize: 13.5),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48.0,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Saved Prompt Version 1.3!')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D1B2A),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                            child: const Text('Save New Version'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
