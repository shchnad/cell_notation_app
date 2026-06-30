import 'package:flutter/material.dart';
import '../enums/hand.dart';
import '../enums/status.dart';
import '../models/beat_model.dart';
import '../models/note_model.dart';
import '../widgets/beat_widget.dart';
import '../widgets/beat_widget.dart';

class CompositionScreen extends StatelessWidget {
  final Map<String, dynamic> config;

  const CompositionScreen({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // 56 rows must fit exactly
    final cellSize = screenHeight / 56;


    final int beatCount = config["beatCount"];
    final double beatDuration = (config["beatDuration"] as dynamic).value;
    final List<Beat> beats = List.generate(beatCount, (i) {
      return Beat(
        id: i.toString(),
        index: i,
        beatDuration: beatDuration,
        measureId: i ~/ 4, // temporary logic (you can improve later)
        notes: List.generate(56, (row) {
          return Note(
            row: row,
            status: Status.silence,
            pitch: null,
            hand: Hand.right,
            createdAt: DateTime.now(),
          );
        }),
      );
    });

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