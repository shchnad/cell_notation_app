import 'package:flutter/material.dart';

import '../enums/hand.dart';
import '../enums/status.dart';
import '../enums/tempo.dart';

import '../models/beat_model.dart';
import '../models/note_model.dart';

import '../services/tonality_service.dart';
import '../widgets/beat_widget.dart';

class CompositionScreen extends StatefulWidget {
  final Map<String, dynamic> config;

  const CompositionScreen({
    super.key,
    required this.config,
  });

  @override
  State<CompositionScreen> createState() => _CompositionScreenState();
}

class _CompositionScreenState extends State<CompositionScreen> {

  Hand currentHand = Hand.right;

  @override
  Widget build(BuildContext context) {

    final int numberOfMeasures =
        (widget.config["numberOfMeasures"] as int?) ?? 0;

    final int beatsPerMeasure =
        (widget.config["beatsPerMeasure"] as int?) ?? 4;

    final int numberOfOctaves =
        (widget.config["numberOfOctaves"] as int?) ?? 8;

    final int rows = numberOfOctaves * 7;
    final int totalBeats = numberOfMeasures * beatsPerMeasure;

    final screenHeight = MediaQuery.of(context).size.height;
    final cellSize = screenHeight / rows;

    final tempo = (widget.config["tempo"] as Tempo).value;

    final tonality = TonalityService.getTonality(
      widget.config["scale"],
      widget.config["tonic"],
    );

    // bottom row = lowest pitch
    final pitchGrid = List.generate(
      rows,
          (i) => tonality[(rows - 1 - i) % tonality.length],
    );

    final actionTime = DateTime.now();

    final beats = List.generate(totalBeats, (i) {
      final measureId = i ~/ beatsPerMeasure;

      return Beat(
        id: i.toString(),
        index: i,
        tempo: tempo,
        measureId: measureId,
        notes: List.generate(rows, (row) {
          return Note(
            row: row,
            pitch: pitchGrid[row],
            status: Status.silence,
            hand: currentHand, // default only (used only when activated)
            createdAt: actionTime,
          );
        }),
      );
    });

    return Scaffold(
      body: Row(
        children: [

          // LEFT MENU
          Container(
            width: 60,
            color: Colors.black,
            child: SafeArea(
              child: Column(
                children: [

                  const SizedBox(height: 20),

                  // HAND TOGGLE
                  IconButton(
                    icon: Icon(
                      Icons.pan_tool,
                      color: currentHand == Hand.left
                          ? Colors.blue
                          : Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      setState(() {
                        currentHand = currentHand == Hand.right
                            ? Hand.left
                            : Hand.right;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  IconButton(
                    icon: const Icon(Icons.home,
                        color: Colors.white, size: 40),
                    onPressed: () => Navigator.pop(context),
                  ),

                  const SizedBox(height: 20),
                  const Icon(Icons.music_note,
                      color: Colors.white, size: 40),
                  const SizedBox(height: 20),
                  const Icon(Icons.settings,
                      color: Colors.white, size: 40),
                ],
              ),
            ),
          ),

          // GRID (ONLY HORIZONTAL SCROLL)
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: beats.asMap().entries.map((entry) {
                  final i = entry.key;
                  final beat = entry.value;

                  final isMeasureStart = i % beatsPerMeasure == 0;

                  return Row(
                    children: [

                      // measure separator
                      if (isMeasureStart && i != 0)
                        Container(
                          width: 1,
                          height: screenHeight,
                          color: Colors.grey.shade500,
                        ),

                      BeatWidget(
                        beat: beat,
                        cellSize: cellSize,
                        currentHand: currentHand,
                      ),
                    ],
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