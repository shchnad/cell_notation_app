import 'package:flutter/material.dart';

enum CellStatus { off, on, cont }

class CellModel {
  CellStatus status;
  String? pitch; // e.g. "2+"
  String? articulation; // MARCATO, LEGATO, etc
  String hand; // left / right

  CellModel({
    this.status = CellStatus.off,
    this.pitch,
    this.articulation,
    this.hand = "right",
  });
}

class CompositionScreen extends StatefulWidget {
  final int measuresCount; // default 3
  final int beatsPerMeasure;

  const CompositionScreen({
    super.key,
    this.measuresCount = 3,
    this.beatsPerMeasure = 4,
  });

  @override
  State<CompositionScreen> createState() => _CompositionScreenState();
}

class _CompositionScreenState extends State<CompositionScreen> {
  static const int pitchRows = 56;
  static const int maxMeasures = 10;

  late List<List<List<CellModel>>> grid;
  // [measure][beat][pitchRow]

  @override
  void initState() {
    super.initState();
    _initGrid();
  }

  void _initGrid() {
    int measures =
    widget.measuresCount.clamp(1, maxMeasures);

    grid = List.generate(measures, (m) {
      return List.generate(widget.beatsPerMeasure, (b) {
        return List.generate(pitchRows, (p) {
          return CellModel();
        });
      });
    });
  }

  void _toggleTap(int m, int b, int p) {
    setState(() {
      final cell = grid[m][b][p];

      if (cell.status == CellStatus.off) {
        cell.status = CellStatus.on;
        cell.pitch = _pitchLabel(p);

        // TODO: trigger sound here
      } else {
        cell.status = CellStatus.off;
        cell.pitch = null;
      }
    });
  }

  void _longPress(int m, int b, int p) {
    setState(() {
      final cell = grid[m][b][p];

      if (cell.status == CellStatus.off) {
        cell.status = CellStatus.cont;
      } else {
        cell.status = CellStatus.off;
      }
    });
  }

  String _pitchLabel(int row) {
    // simple placeholder mapping (you will replace with tonal engine)
    const degrees = ["1", "2", "3", "4", "5", "6", "7"];
    return degrees[row % 7];
  }

  Border _articulationBorder(String? art) {
    switch (art) {
      case "MARCATO":
        return Border.all(color: Colors.red, width: 2);

      case "TENUTO":
        return const Border(
          top: BorderSide(color: Colors.red, width: 2),
        );

      case "LEGATO":
        return const Border(
          bottom: BorderSide(color: Colors.red, width: 2),
        );

      case "STACCATO":
        return const Border(
          left: BorderSide(color: Colors.red, width: 2),
        );

      default:
        return Border.all(color: Colors.transparent);
    }
  }

  Color _cellColor(CellModel cell) {
    if (cell.status == CellStatus.off) {
      return Colors.white;
    }
    return cell.hand == "left"
        ? Colors.blue
        : Colors.black;
  }

  Widget _buildCell(int m, int b, int p, double size) {
    final cell = grid[m][b][p];

    return GestureDetector(
      onTap: () => _toggleTap(m, b, p),
      onLongPress: () => _longPress(m, b, p),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: _cellColor(cell),
          border: _articulationBorder(cell.articulation),
        ),
        child: Center(
          child: cell.status == CellStatus.on
              ? Text(
            cell.pitch ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cellSize =
            constraints.maxWidth / widget.beatsPerMeasure;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int p = 0; p < pitchRows; p++)
                  Row(
                    children: [
                      for (int m = 0;
                      m < grid.length;
                      m++)
                        for (int b = 0;
                        b < widget.beatsPerMeasure;
                        b++)
                          _buildCell(m, b, p, cellSize),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Composition"),
        backgroundColor: Colors.black,
      ),
      body: _buildGrid(),
    );
  }
}
