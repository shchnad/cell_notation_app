import '../enums/status.dart';
import '../enums/hand.dart';
import '../enums/nuance.dart';
import '../enums/articulation.dart';
import '../enums/finger.dart';
import '../enums/accidental.dart';
import '../enums/ornament.dart';

class Note {
  final int row; // 0–55 pitch grid
  final Status status;
  final Hand hand;
  final Finger? finger;
  final Accidental? accidental;
  final Articulation? articulation;
  final Ornament? ornament;
  final Nuance? nuance;
  final DateTime createdAt;

  const Note({
    required this.row,
    required this.status,
    required this.hand,
    this.finger,
    this.accidental,
    this.articulation,
    this.ornament,
    this.nuance,
    required this.createdAt,
  });
}