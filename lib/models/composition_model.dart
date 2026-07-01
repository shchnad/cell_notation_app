import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/beat_model.dart';

class Composition {
  final String id;
  final String title;
  final String composer;
  final String createdByUser;
  final String style;
  final String instrument;
  final String scale;
  final String tonic;
  final double beatDuration;
  final List<Beat> beats;
  final DateTime createdAt;
  final DateTime updatedAt;

  Composition({
    required this.id,
    required this.title,
    required this.composer,
    required this.createdByUser,
    required this.style,
    required this.instrument,
    required this.scale,
    required this.tonic,
    required this.beatDuration,
    required this.beats,
    required this.createdAt,
    required this.updatedAt, required tempo,
  });
}