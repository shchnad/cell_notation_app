import '../enums/status.dart';
import '../enums/hand.dart';
import '../enums/nuance.dart';
import '../enums/articulation.dart';
import '../enums/finger.dart';
import '../enums/accidental.dart';
import '../enums/ornament.dart';

class Note {
  final int cellId;
  final int step;
  final int octave;
  final Status status;
  final Hand hand;
  final Finger? finger;
  final Accidental? accidental;
  final Articulation? articulation;
  final Ornament? ornament;
  final Nuance? nuance;
  final DateTime createdAt;

  Note({
    required this.cellId,
    required this.step,
    required this.octave,
    required this.status,
    required this.hand,
    this.finger,
    this.accidental,
    this.articulation,
    this.ornament,
    this.nuance,
    required this.createdAt,
  }) : assert(
  status != Status.empty || articulation == null,
  'Empty cells cannot have articulation',
  );

  Note copyWith({
    int? cellId,
    int? step,
    int? octave,
    Status? status,
    Hand? hand,
    Finger? finger,
    Accidental? accidental,
    Articulation? articulation,
    Ornament? ornament,
    Nuance? nuance,
    DateTime? createdAt,
  }) {
    return Note(
      cellId: cellId ?? this.cellId,
      step: step ?? this.step,
      octave: octave ?? this.octave,
      status: status ?? this.status,
      hand: hand ?? this.hand,
      finger: finger ?? this.finger,
      accidental: accidental ?? this.accidental,
      articulation: articulation ?? this.articulation,
      ornament: ornament ?? this.ornament,
      nuance: nuance ?? this.nuance,
      createdAt: createdAt ?? this.createdAt,
    );
  }}