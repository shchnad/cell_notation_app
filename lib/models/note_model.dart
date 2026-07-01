import '../enums/status.dart';
import '../enums/hand.dart';
import '../enums/nuance.dart';
import '../enums/articulation.dart';
import '../enums/finger.dart';
import '../enums/accidental.dart';
import '../enums/ornament.dart';

class Note {
  final int row;
  Status status;
  final String pitch;
  Hand hand;
  Finger? finger;
  Accidental? accidental;
  Articulation? articulation;
  Ornament? ornament;
  Nuance? nuance;
  final DateTime createdAt;

  Note({
    required this.row,
    required this.status,
    required this.pitch,
    required this.hand,
    this.finger,
    this.accidental,
    this.articulation,
    this.ornament,
    this.nuance,
    required this.createdAt,
  });
}