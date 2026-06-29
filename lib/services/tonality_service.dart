class TonalityService {
  static List<String> getScale(String scale, String tonic) {
    final scaleArrayName = '$scale $tonic';
    switch (scaleArrayName) {

    // MAJOR

      case 'natural major C':
        return ['1', '2', '3', '4', '5', '6', '7'];

      case 'natural major C sharp':
        return ['1+', '2+', '3+', '4+', '5+', '6+', '7+'];

      case 'natural major D flat':
        return ['1', '2-', '3-', '4', '5-', '6-', '7-'];

      case 'natural major D':
        return ['1+', '2', '3', '4+', '5', '6', '7'];

      case 'natural major D sharp':
        return ['1++', '2+', '3+', '4++', '5+', '6+', '7+'];

      case 'natural major E flat':
        return ['1', '2', '3-', '4', '5', '6-', '7-'];

      case 'natural major E':
        return ['1+', '2+', '3', '4+', '5+', '6', '7'];

      case 'natural major F':
        return ['1', '2', '3', '4', '5', '6', '7-'];

      case 'natural major F sharp':
        return ['1+', '2+', '3+', '4+', '5+', '6+', '7'];

      case 'natural major G flat':
        return ['1-', '2-', '3-', '4', '5-', '6-', '7-'];

      case 'natural major G':
        return ['1', '2', '3', '4+', '5', '6', '7'];

      case 'natural major G sharp':
        return ['1+', '2+', '3+', '4++', '5+', '6+', '7+'];

      case 'natural major A flat':
        return ['1', '2-', '3-', '4', '5', '6-', '7-'];

      case 'natural major A':
        return ['1+', '2', '3', '4+', '5+', '6', '7'];

      case 'natural major A sharp':
        return ['1++', '2+', '3+', '4++', '5++', '6+', '7+'];

      case 'natural major B flat':
        return ['1', '2', '3-', '4', '5', '6', '7-'];

    //  MINOR

      case 'natural minor C':
        return ['1', '2', '3-', '4', '5', '6-', '7-'];

      case 'natural minor C sharp':
        return ['1+', '2+', '3', '4+', '5+', '6', '7'];

      case 'natural minor D flat':
        return ['1-', '2-', '3-', '4-', '5-', '6-', '7--'];

      case 'natural minor D':
        return ['1', '2', '3', '4', '5', '6', '7-'];

      case 'natural minor D sharp':
        return ['1+', '2+', '3+', '4+', '5+', '6+', '7'];

      case 'natural minor E flat':
        return ['1-', '2-', '3-', '4', '5-', '6-', '7-'];

      case 'natural minor E':
        return ['1', '2', '3', '4+', '5', '6', '7'];

      case 'natural minor F':
        return ['1', '2-', '3-', '4', '5', '6-', '7-'];

      case 'natural minor F sharp':
        return ['1+', '2', '3', '4+', '5+', '6', '7'];

      case 'natural minor G flat':
        return ['1-', '2-', '3--', '4-', '5-', '6-', '7--'];

      case 'natural minor G':
        return ['1', '2', '3-', '4', '5', '6', '7-'];

      case 'natural minor G sharp':
        return ['1+', '2+', '3', '4+', '5+', '6+', '7'];

      case 'natural minor A flat':
        return ['1-', '2-', '3-', '4-', '5-', '6-', '7-'];

      case 'natural minor A':
        return ['1', '2', '3', '4', '5', '6', '7'];

      case 'natural minor A sharp':
        return ['1+', '2+', '3+', '4+', '5+', '6+', '7+'];

      case 'natural minor B flat':
        return ['1', '2-', '3-', '4', '5-', '6-', '7-'];

      case 'natural minor B':
        return ['1+', '2', '3', '4+', '5', '6', '7'];

      default:
        throw ArgumentError(
          'Unsupported tonality: $scale $tonic',
        );
    }
  }
}