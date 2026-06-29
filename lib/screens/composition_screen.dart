import 'package:flutter/material.dart';
import '../models/beat_model.dart';
import '../widgets/beat_widget.dart';
import '../widgets/beat_widget.dart';

class CompositionScreen extends StatelessWidget {
  final List<Beat> beats;

  const CompositionScreen({
    super.key,
    required this.beats,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // 56 rows must fit exactly
    final cellSize = screenHeight / 56;

    return Scaffold(
      body: Row(
        children: [
          // LEFT SIDEBAR
          Container(
            width: 50,
            color: Colors.black,
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  IconButton(
                    icon: const Icon(Icons.home, color: Colors.white, size: 40),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  const Icon(Icons.music_note, color: Colors.white, size: 40),
                  const SizedBox(height: 20),
                  const Icon(Icons.settings, color: Colors.white, size: 40),
                ],
              ),
            ),
          ),
          // GRID AREA
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: beats.map((beat) {
                  return BeatWidget(
                    beat: beat,
                    cellSize: cellSize,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}