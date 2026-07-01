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

    final int numberOfMeasures = config["numberOfMeasures"] ?? 0;
    final int beatsPerMeasure = config["beatsPerMeasure"] ?? 4;
    final int numberOfOctaves = config["numberOfOctaves"] ?? 8;

    final int rows = numberOfOctaves * 7;
    final int totalBeats = numberOfMeasures * beatsPerMeasure;

    final screenHeight = MediaQuery.of(context).size.height;
    final cellSize = screenHeight / rows;

    final tempo = (config["tempo"] as Tempo).value;

    final List<String> tonality = TonalityService.getTonality(
      config["scale"],
      config["tonic"],
    );
    final int scaleLength = tonality.length;

    final DateTime actionTime = DateTime.now();

    final List<Beat> beats = List.generate(totalBeats, (i) {
      final int measureId = i ~/ beatsPerMeasure;
      return Beat(
        id: i.toString(),
        index: i,
        tempo: tempo,
        measureId: measureId,
        notes: List.generate(rows, (row) {
          final int invertedRow = rows - 1 - row;
          return Note(
            row: row,
            pitch: tonality[invertedRow % scaleLength],
            status: Status.silence,
            hand: Hand.right,
            createdAt: actionTime,
          );
        }),
      );
    });


    // UI

    return Scaffold(
      body: Row(
        children: [
          // SIDEBAR
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

          // HORIZONTAL GRID ONLY
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