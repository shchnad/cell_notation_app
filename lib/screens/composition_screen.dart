import 'package:flutter/material.dart';

import '../enums/hand.dart';
import '../enums/status.dart';
import '../enums/tempo.dart';

import '../models/beat_model.dart';
import '../models/note_model.dart';

import '../services/tonality_service.dart';
import '../widgets/beat_widget.dart';

class CompositionScreen extends StatelessWidget {
  final Map<String, dynamic> config;

  const CompositionScreen({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {

    final actionTime = DateTime.now();

    final int numberOfMeasures = (config["numberOfMeasures"] as int?) ?? 0;
    final int beatsPerMeasure = (config["beatsPerMeasure"] as int?) ?? 4;
    final int numberOfOctaves = (config["numberOfOctaves"] as int?) ?? 8;

    final int rows = numberOfOctaves * 7;
    final int beatCount = numberOfMeasures * beatsPerMeasure;

    final screenHeight = MediaQuery.of(context).size.height;
    final cellSize = screenHeight / rows;

    final tempo = (config["tempo"] as Tempo).value;

    final tonality = TonalityService.getTonality(
      config["scale"],
      config["tonic"],
    );

    final pitchGrid = List.generate(
      rows,
          (row) => tonality[row % tonality.length],
    );

    final int totalBeats = numberOfMeasures * beatsPerMeasure;

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
            hand: Hand.right,
            createdAt: actionTime,
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

          // GRID
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
                          width: 3,
                          height: screenHeight,
                          color: Colors.black,
                        ),

                      BeatWidget(
                        beat: beat,
                        cellSize: cellSize,
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