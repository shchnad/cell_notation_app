import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../enums/instrument.dart';
import '../enums/style.dart';
import '../enums/beat_duration.dart';
import '../services/content_filter_service.dart';
import '../enums/tempo.dart';

class CreateCompositionDialog extends StatefulWidget {
  const CreateCompositionDialog({super.key});

  @override
  State<CreateCompositionDialog> createState() =>
      _CreateCompositionDialogState();
}

class _CreateCompositionDialogState
    extends State<CreateCompositionDialog> {

  final user = FirebaseAuth.instance.currentUser;

  int step = 0;

  // 1 - TITLE
  final titleController = TextEditingController();
  final composerController = TextEditingController();
  String? titleError;
  String? composerError;

  // 2 - STYLE
  Style selectedStyle = Style.any;

  // 3 - INSTRUMENT
  Instrument selectedInstrument = Instrument.any;
  final customInstrumentController = TextEditingController();
  bool useCustomInstrument = false;
  String? customInstrumentError;

  // 4 - TONALITY
  String scale = "natural major";
  String tonic = "C";

  // 5 - BEAT DURATION
  BeatDuration beatDuration = BeatDuration.eighth;

  // 6 - TEMPO
  Tempo selectedTempo = Tempo.lento;

  // 7 - COLUMNS and ROW ADDING
  int numberOfMeasures = 0;
  int beatsPerMeasure = 4;
  int numberOfOctaves = 8;


  @override
  void dispose() {
    titleController.dispose();
    composerController.dispose();
    customInstrumentController.dispose();
    super.dispose();
  }

  String beatLabel(BeatDuration d) {
    switch (d) {
      case BeatDuration.whole:
        return "1";
      case BeatDuration.half:
        return "1/2";
      case BeatDuration.quarter:
        return "1/4";
      case BeatDuration.eighth:
        return "1/8";
      case BeatDuration.sixteenth:
        return "1/16";
      case BeatDuration.thirtySecond:
        return "1/32";
      case BeatDuration.sixtyFourth:
        return "1/64";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          "enter values ${step + 1} of 7",
          style: const TextStyle(fontSize: 22),
        ),
      ),
      content: SizedBox(
        width: 600,
        height: 800,
        child: _buildStep(),
      ),
      actions: [
        if (step > 0)
          TextButton(
            onPressed: () => setState(() => step--),
            child: const Text("Back", style: TextStyle(fontSize: 22)),
          ),
        ElevatedButton(
          onPressed: () {
            if (step == 0) {
              if (titleController.text.trim().isEmpty ||
                  composerController.text.trim().isEmpty ||
                  !ContentFilterService.isValid(titleController.text) ||
                  !ContentFilterService.isValid(composerController.text)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Invalid content",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                );
                return;
              }
            }
            if (step == 2) {
              if (useCustomInstrument) {
              if (customInstrumentController.text.trim().isEmpty ||
                  !ContentFilterService.isValid(customInstrumentController.text.trim())) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Invalid content",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                );
                return;
                }
              }
            }
            if (step < 6) {
              setState(() => step++);
            } else {
               {
                Navigator.pop(context, {
                  "title": titleController.text.trim(),
                  "composer": composerController.text.trim(),
                  "createdByUser": user?.uid ?? "",
                  "style": selectedStyle,
                  "instrument": useCustomInstrument
                    ? customInstrumentController.text.trim()
                    : selectedInstrument.name,
                  "scale": scale,
                  "tonic": tonic,
                  "beatDuration": beatDuration,
                  "tempo": selectedTempo,
                  "numberOfMeasures": numberOfMeasures,
                  "beatsPerMeasure": beatsPerMeasure,
                  "createdAt": DateTime.now(),
                  "updatedAt": DateTime.now(),
                  "numberOfOctaves": numberOfOctaves,
                });
              }
            }
          },
          child: Text(step == 6 ? "Create" : "Next",
              style: TextStyle(fontSize: 22)),
        ),
      ],
    );
  }


  Widget _buildStep() {
    switch (step) {

    // 1 - TITLE
      case 0:
        return ListView(
          children: [
            const SizedBox(height: 20),
            const Text("Title of music",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            TextField(
              controller: titleController,
              style: TextStyle(fontSize: 22, color: Colors.indigo),
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty ||
                      ContentFilterService.isValid(value)) {
                    titleError = null;
                  } else {
                    titleError = "Invalid title";
                  }
                });
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "type title of the music here",
                hintStyle: const TextStyle(fontSize: 22),
                errorText: titleError,
              ),
            ),
            const SizedBox(height: 50),
            const Text("Composer's name",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center
            ),
            TextField(
              controller: composerController,
              style: TextStyle(fontSize: 22, color: Colors.indigo),
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty ||
                      ContentFilterService.isValid(value)) {
                    composerError = null;
                  } else {
                    composerError = "Invalid composer";
                  }
                });
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "type composer's name here",
                hintStyle: const TextStyle(fontSize: 22),
                errorText: composerError,
              ),
            ),
          ],
        );

    // 2 - STYLE

      case 1:
        return Column(
          children: [
          // const SizedBox(height: 20),
          const Text("Style",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SingleChildScrollView(
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: Style.values.map((s) {
              return SizedBox(
                width: 260, // controls 2 columns
                child: RadioListTile<Style>(
                  dense: true,
                  title: Text(s.name, style: TextStyle(fontSize: 22),),
                  value: s,
                  groupValue: selectedStyle,
                  onChanged: (v) => setState(() => selectedStyle = v!),
                ),
              );
            }).toList(),
          ),
        ),
    ],);

    // 3 - INSTRUMENT

      case 2:
        return SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Instrument",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              // CUSTOM INSTRUMENT
              RadioListTile<bool>(
                dense: true,
                visualDensity: const VisualDensity(
                  horizontal: -4,
                  vertical: -4,
                ),
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  "Custom instrument",
                  style: TextStyle(fontSize: 22),
                ),
                value: true,
                groupValue: useCustomInstrument,
                onChanged: (v) => setState(() {
                  useCustomInstrument = v!;
                  if (useCustomInstrument) {
                    selectedInstrument = Instrument.any;
                  }
                }),
                subtitle: useCustomInstrument
                    ? Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextField(
                    controller: customInstrumentController,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty ||
                            ContentFilterService.isValid(value)) {
                          customInstrumentError = null;
                        } else {
                          customInstrumentError =
                          "Invalid content";
                        }
                      });
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Type your instrument here",
                      hintStyle: const TextStyle(fontSize: 22),
                      errorText: customInstrumentError,
                    ),
                  ),
                )
                    : null,
              ),
              const SizedBox(height: 20),
              // PREDEFINED INSTRUMENTS
              Wrap(
                spacing: 0,
                runSpacing: 0,
                children: Instrument.values.map((instrument) {
                  return SizedBox(
                    width: 260,
                    child: RadioListTile<Instrument>(
                      dense: true,
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        instrument.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      value: instrument,
                      groupValue: selectedInstrument,
                      onChanged: (v) => setState(() {
                        selectedInstrument = v!;
                        useCustomInstrument = false;
                        customInstrumentError = null;
                      }),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );

    // 4 - TONALITY

      case 3:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const SizedBox(height: 20),

              // SCALE SECTION

              const Text("Scale",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  "natural major",
                  "natural minor",
                ].map((s) {
                  return SizedBox(
                    width: 260,
                    child: RadioListTile<String>(
                      dense: true,
                      title: Text(s, style: TextStyle(fontSize: 22)),
                      value: s,
                      groupValue: scale,
                      onChanged: (v) => setState(() => scale = v!),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // TONIC SECTION

              const Text(
                "Tonic",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 5,
                children: [
                  "C", "C sharp", "D flat",
                  "D", "D sharp", "E flat",
                  "E", "F", "F sharp",
                  "G flat", "G", "G sharp",
                  "A flat", "A", "A sharp",
                  "B flat", "B",
                ].map((t) {
                  return RadioListTile<String>(
                    title: Text(
                      t,
                      style: const TextStyle(fontSize: 22),
                    ),
                    value: t,
                    groupValue: tonic,
                    onChanged: (v) => setState(() => tonic = v!),
                  );
                }).toList(),
              ),
            ],
          ),
        );


    // 5 - BEAT DURATION

      case 4:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 20),

              const Center(
                child: Text("Beat Duration",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              ...BeatDuration.values.map((d) {
                return RadioListTile<BeatDuration>(
                  title: Text(
                    beatLabel(d),
                    style: const TextStyle(fontSize: 22),
                  ),
                  value: d,
                  groupValue: beatDuration,
                  onChanged: (value) {
                    setState(() {
                      beatDuration = value!;
                    });
                  },
                );
              }),
            ],
          ),
        );


    // 6 - TEMPO

      case 5:
        return Column(
          children: [
            // const SizedBox(height: 20),
            const Text("Tempo",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SingleChildScrollView(
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: Tempo.values.map((s) {
                  return SizedBox(
                    width: 260, // controls 2 columns
                    child: RadioListTile<Tempo>(
                      dense: true,
                      title: Text(s.name, style: TextStyle(fontSize: 22),),
                      value: s,
                      groupValue: selectedTempo,
                      onChanged: (v) => setState(() => selectedTempo = v!),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],);


    // 7 - COLUMNS AND ROWS ADDING

      case 6:
        return ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: RadioListTile<int>(
                    title: const Text("4 octaves", style: TextStyle(fontSize: 22),),
                    value: 4,
                    groupValue: numberOfOctaves,
                    onChanged: (value) {
                      setState(() => numberOfOctaves = value!);
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<int>(
                    title: const Text("8 octaves", style: TextStyle(fontSize: 22),),
                    value: 8,
                    groupValue: numberOfOctaves,
                    onChanged: (value) {
                      setState(() => numberOfOctaves = value!);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Text("number of measures",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            TextField(
              style: TextStyle(fontSize: 22, color: Colors.indigo),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "type here the number of measures to add",
                hintStyle: const TextStyle(fontSize: 22),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) =>
              numberOfMeasures = int.tryParse(v) ?? 0,
            ),
            const SizedBox(height: 20),
            const Text("number of beats per measure",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            TextField(
              style: TextStyle(fontSize: 22, color: Colors.indigo),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "type here how many beats per measure you need",
                hintStyle: const TextStyle(fontSize: 22),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) =>
              beatsPerMeasure = int.tryParse(v) ?? 1,
            ),
          ],
        );


      default:
        return const SizedBox();
    }
  }
}