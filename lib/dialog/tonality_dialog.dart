// import 'package:flutter/material.dart';
//
//
// class TonalityDialog extends StatefulWidget {
//   const TonalityDialog({super.key});
//
//   @override
//   State<TonalityDialog> createState() => _TonalityDialogState();
// }
//
// class _TonalityDialogState extends State<TonalityDialog> {
//   String scale = "natural major";
//   String tonic = "C";
//
//   final tonics = [
//     "C",
//     "C sharp",
//     "D flat",
//     "D",
//     "D sharp",
//     "E flat",
//     "E",
//     "F",
//     "F sharp",
//     "G flat",
//     "G",
//     "G sharp",
//     "A flat",
//     "A",
//     "A sharp",
//     "B flat",
//     "B",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Center(
//         child: Text(
//           "Choose Tonality",
//           style: TextStyle(fontSize: 22),
//         ),
//       ),
//       content: SizedBox(
//         width: 350,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//
//             RadioListTile<String>(
//               title: const Text("Natural Major"),
//               value: "natural major",
//               groupValue: scale,
//               onChanged: (v) => setState(() => scale = v!),
//             ),
//
//             RadioListTile<String>(
//               title: const Text("Natural Minor"),
//               value: "natural minor",
//               groupValue: scale,
//               onChanged: (v) => setState(() => scale = v!),
//             ),
//
//             const Divider(),
//
//             SizedBox(
//               height: 250,
//               child: ListView(
//                 children: tonics.map((t) {
//                   return RadioListTile<String>(
//                     title: Text(t),
//                     value: t,
//                     groupValue: tonic,
//                     onChanged: (v) => setState(() => tonic = v!),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text("Cancel"),
//         ),
//
//         ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context, {
//               "scale": scale,
//               "tonic": tonic,
//             });
//           },
//           child: const Text("Create"),
//         ),
//       ],
//     );
//   }
// }