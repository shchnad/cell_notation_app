import 'package:flutter/material.dart';
import '../enums/instrument.dart';
import '../enums/style.dart';
import '../enums/beat_duration.dart';
import '../services/content_filter_service.dart';

class CreateCompositionDialog extends StatefulWidget {
  const CreateCompositionDialog({super.key});

  @override
  State<CreateCompositionDialog> createState() =>
      _CreateCompositionDialogState();
}

class _CreateCompositionDialogState
    extends State<CreateCompositionDialog> {

  int step = 0;

  // TITLE
  final titleController = TextEditingController();
  final composerController = TextEditingController();

  // STYLE
  Style selectedStyle = Style.none;

  // INSTRUMENT
  Instrument selectedInstrument = Instrument.none;
  final customInstrumentController = TextEditingController();
  bool useCustomInstrument = false;

  // TONALITY
  String scale = "natural major";
  String tonic = "C";

  // GRID
  int beatCount = 16;
  int beatsPerMeasure = 4;

  // DURATION
  BeatDuration beatDuration = BeatDuration.quarter;

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

    // HERE YOU WILL PASS DATA TO GRID ENGINE
    debugPrint("TITLE: ${titleController.text}");
    debugPrint("COMPOSER: ${composerController.text}");
    debugPrint("STYLE: ${selectedStyle.name}");
    debugPrint("INSTRUMENT: $instrument");
    debugPrint("TONALITY: $scale $tonic");
    debugPrint("BEAT COUNT: $beatCount");
    debugPrint("BPM TYPE: ${beatDuration.name}");

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          "Choose values for your composition (${step + 1}/6)",
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
            child: const Text("Back", style: TextStyle(fontSize: 22),),
          ),
        ElevatedButton(
          onPressed: () {
            if (step == 0) {
              if (titleController.text.trim().isEmpty ||
                  composerController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Enter title and composer",
                      style: TextStyle(fontSize: 16),
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
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
                return;
              }
            }

            if (step < 5) {
              setState(() => step++);
            } else {
              createComposition();
            }
          },
          child: Text(step == 5 ? "Create" : "Next", style: TextStyle(fontSize: 22)),
        ),
      ],
    );
  }

  Widget _buildStep() {
    switch (step) {

    // TITLE
      case 0:
        return ListView(
          children: [
            const SizedBox(height: 20),
            const Text("Input Title", style: TextStyle(fontSize: 22), textAlign: TextAlign.center),
            TextField(
              controller: titleController,
              style: TextStyle(fontSize: 22, color: Colors.indigo),
              decoration: const InputDecoration(
                hintText: "e.g. Moon Sonata",
              ),
            ),
            const SizedBox(height: 50),
            const Text("Input Composer", style: TextStyle(fontSize: 22), textAlign: TextAlign.center),
            TextField(
              controller: composerController,
              style: TextStyle(fontSize: 22, color: Colors.indigo),
              decoration: const InputDecoration(
                hintText: "e.g. J.S.Bach",
              ),
            ),
          ],
        );

    // STYLE
      case 1:
        return Column(
          children: [
          const SizedBox(height: 20),
          const Text("Choose Style", style: TextStyle(fontSize: 22)),
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

    // INSTRUMENT
      case 2:
        return SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text("Choose Instrument", style: TextStyle(fontSize: 22)),
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
                      hintText: "e.g. Electric Synth Pad",
                    ),
                  ),
                ),
            ],
          ),
        );

    // TONALITY
      case 3:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const Text("Choose Tonality", style: TextStyle(fontSize: 22)),
              const SizedBox(height: 50),

              // SCALE SECTION
              const Text("Choose Scale", style: TextStyle(fontSize: 22)),

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
                "Choose Tonic",
                style: TextStyle(fontSize: 22)),

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

    // DURATION
      case 4:
        return ListView(
          children: BeatDuration.values.map((d) {
            return RadioListTile(
              title: Text(beatLabel(d), style: TextStyle(fontSize: 22)),
              value: d,
              groupValue: beatDuration,
              onChanged: (v) => setState(() => beatDuration = v!),
            );
          }).toList(),
        );

    // GRID
      case 5:
        return ListView(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Beat count",
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) =>
              beatCount = int.tryParse(v) ?? 16,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "Beats per measure",
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) =>
              beatsPerMeasure = int.tryParse(v) ?? 4,
            ),
          ],
        );

      default:
        return const SizedBox();
    }
  }
}