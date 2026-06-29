import 'package:flutter/material.dart';
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

  int step = 0;

  // 1 - TITLE
  final titleController = TextEditingController();
  final composerController = TextEditingController();

  // 2 - STYLE
  Style selectedStyle = Style.none;

  // 3 - INSTRUMENT
  Instrument selectedInstrument = Instrument.none;
  final customInstrumentController = TextEditingController();
  bool useCustomInstrument = false;

  // 4 - TONALITY
  String scale = "natural major";
  String tonic = "C";

  // 5 - BEAT DURATION
  BeatDuration beatDuration = BeatDuration.quarter;

  // 6 - TEMPO
  Tempo selectedTempo = Tempo.lento;

  // 7 - COLUMNS ADDING
  int beatCount = 0;
  int beatsPerMeasure = 4;


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

  String getFinalInstrument() {
    if (useCustomInstrument) {
      return customInstrumentController.text.trim();
    }
    return selectedInstrument.name;
  }

  void createComposition() {
    final instrument = getFinalInstrument();
    debugPrint("TITLE: ${titleController.text}");
    debugPrint("COMPOSER: ${composerController.text}");
    debugPrint("STYLE: ${selectedStyle.name}");
    debugPrint("INSTRUMENT: $instrument");
    debugPrint("TONALITY: $scale $tonic");
    debugPrint("TEMPO: ${selectedTempo.name}");
    debugPrint("BEAT COUNT: $beatCount");
    debugPrint("BPM TYPE: ${beatDuration.name}");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          "Enter value ${step + 1} of 7",
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
                  composerController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Enter content",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                );
                return;
              }
              if (!ContentFilterService.isValid(titleController.text) ||
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
            if (step < 6) {
              setState(() => step++);
            } else {
               {
                Navigator.pop(context, {
                  "title": titleController.text.trim(),
                  "composer": composerController.text.trim(),
                  "style": selectedStyle,
                  "instrument": getFinalInstrument(),
                  "scale": scale,
                  "tonic": tonic,
                  "beatDuration": beatDuration,
                  "tempo": selectedTempo,
                  "beatCount": beatCount,
                  "beatsPerMeasure": beatsPerMeasure,
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
              decoration: const InputDecoration(
                hintText: "e.g. Moon Sonata",
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
              decoration: const InputDecoration(
                hintText: "e.g. Beethoven L.",
              ),
            ),
          ],
        );

    // 2 - STYLE
      case 1:
        return Column(
          children: [
          const SizedBox(height: 20),
          const Text("Style",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SingleChildScrollView(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
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
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text("Instrument",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: Instrument.values
                    .where((i) => i != Instrument.none)
                    .map((instrument) {
                  return SizedBox(
                    width: 260, // 👈 2 columns
                    child: RadioListTile<Instrument>(
                      dense: true,
                      title: Text(instrument.name, style: TextStyle(fontSize: 22),),
                      value: instrument,
                      groupValue: selectedInstrument,
                      onChanged: (v) => setState(() {
                        selectedInstrument = v!;
                        useCustomInstrument = false;
                      }),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // CUSTOM INSTRUMENT
              RadioListTile<bool>(
                title: const Text("Custom instrument"),
                value: true,
                groupValue: useCustomInstrument,
                onChanged: (v) => setState(() {
                  useCustomInstrument = true;
                  selectedInstrument = Instrument.none;
                }),
              ),
              if (useCustomInstrument)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: customInstrumentController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "type your instrument",
                    ),
                  ),
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
              const SizedBox(height: 50),
              // SCALE SECTION
              const Text("Scale",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 10,
                runSpacing: 10,
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
              const SizedBox(height: 50),
              // TONIC SECTION
              const Text(
                "Tonic",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  "C", "C sharp", "D flat", "D",
                  "D sharp", "E flat", "E",
                  "F", "F sharp", "G flat", "G",
                  "G sharp", "A flat", "A",
                  "A sharp", "B flat", "B",
                ].map((t) {
                  return SizedBox(
                    width: 260,
                    child: RadioListTile<String>(
                      dense: true,
                      title: Text(t, style: TextStyle(fontSize: 22)),
                      value: t,
                      groupValue: tonic,
                      onChanged: (v) => setState(() => tonic = v!),
                    ),
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
              const SizedBox(height: 20),

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
                    style: const TextStyle(fontSize: 20),
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
            const SizedBox(height: 20),
            const Text("Tempo",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SingleChildScrollView(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
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


    // 7 - COLUMNS ADDING
      case 6:
        return ListView(
          children: [
            TextField(
              style: TextStyle(fontSize: 22, color: Colors.indigo),
              decoration: const InputDecoration(
                labelText: "Number of beats to add",
                  labelStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) =>
              beatCount = int.tryParse(v) ?? 0,
            ),
            const SizedBox(height: 20),
            TextField(
              style: TextStyle(fontSize: 22, color: Colors.indigo),
              decoration: const InputDecoration(
                labelText: "Number of beats per measure",
                  labelStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) =>
              beatsPerMeasure = int.tryParse(v) ?? 0,
            ),
          ],
        );


      default:
        return const SizedBox();
    }
  }
}