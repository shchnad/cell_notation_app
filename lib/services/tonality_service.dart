
class TonalityService {
  static List<String> getScale(String scale, String tonic) {

    switch (scaleArrayName) {

    // MAJOR

      case 'natural major C':
        scaleArray = ['1', '2', '3', '4', '5', '6', '7'];
        break;

      case 'natural major C sharp':
        scaleArray = ['1+', '2+', '3+', '4+', '5+', '6+', '7+'];
        break;

      case 'natural major D flat':
        scaleArray = ['1', '2-', '3-', '4', '5-', '6-', '7-'];
        break;

      case 'natural major D':
        scaleArray = ['1+', '2', '3', '4+', '5', '6', '7'];
        break;

      case 'natural major D sharp':
        scaleArray = ['1++', '2+', '3+', '4++', '5+', '6+', '7+'];
        break;

      case 'natural major E flat':
        scaleArray = ['1', '2', '3-', '4', '5', '6-', '7-'];
        break;

      case 'natural major E':
        scaleArray = ['1+', '2+', '3', '4+', '5+', '6', '7'];
        break;

      case 'natural major F':
        scaleArray = ['1', '2', '3', '4', '5', '6', '7-'];
        break;

      case 'natural major F sharp':
        scaleArray = ['1+', '2+', '3+', '4+', '5+', '6+', '7'];
        break;

      case 'natural major G flat':
        scaleArray = ['1-', '2-', '3-', '4', '5-', '6-', '7-'];
        break;

      case 'natural major G':
        scaleArray = ['1', '2', '3', '4+', '5', '6', '7'];
        break;

      case 'natural major G sharp':
        scaleArray = ['1+', '2+', '3+', '4++', '5+', '6+', '7+'];
        break;

      case 'natural major A flat':
        scaleArray = ['1', '2-', '3-', '4', '5', '6-', '7-'];
        break;

      case 'natural major A':
        scaleArray = ['1+', '2', '3', '4+', '5+', '6', '7'];
        break;

      case 'natural major A sharp':
        scaleArray = ['1++', '2+', '3+', '4++', '5++', '6+', '7+'];
        break;

      case 'natural major B flat':
        scaleArray = ['1', '2', '3-', '4', '5', '6', '7-'];
        break;

    //  MINOR

      case 'natural minor C':
        scaleArray = ['1', '2', '3-', '4', '5', '6-', '7-'];
        break;

      case 'natural minor C sharp':
        scaleArray = ['1+', '2+', '3', '4+', '5+', '6', '7'];
        break;

      case 'natural minor D flat':
        scaleArray = ['1-', '2-', '3-', '4-', '5-', '6-', '7--'];
        break;

      case 'natural minor D':
        scaleArray = ['1', '2', '3', '4', '5', '6', '7-'];
        break;

      case 'natural minor D sharp':
        scaleArray = ['1+', '2+', '3+', '4+', '5+', '6+', '7'];
        break;

      case 'natural minor E flat':
        scaleArray = ['1-', '2-', '3-', '4', '5-', '6-', '7-'];
        break;

      case 'natural minor E':
        scaleArray = ['1', '2', '3', '4+', '5', '6', '7'];
        break;

      case 'natural minor F':
        scaleArray = ['1', '2-', '3-', '4', '5', '6-', '7-'];
        break;

      case 'natural minor F sharp':
        scaleArray = ['1+', '2', '3', '4+', '5+', '6', '7'];
        break;

      case 'natural minor G flat':
        scaleArray = ['1-', '2-', '3--', '4-', '5-', '6-', '7--'];
        break;

      case 'natural minor G':
        scaleArray = ['1', '2', '3-', '4', '5', '6', '7-'];
        break;

      case 'natural minor G sharp':
        scaleArray = ['1+', '2+', '3', '4+', '5+', '6+', '7'];
        break;

      case 'natural minor A flat':
        scaleArray = ['1-', '2-', '3-', '4-', '5-', '6-', '7-'];
        break;

      case 'natural minor A':
        scaleArray = ['1', '2', '3', '4', '5', '6', '7'];
        break;

      case 'natural minor A sharp':
        scaleArray = ['1+', '2+', '3+', '4+', '5+', '6+', '7+'];
        break;

      case 'natural minor B flat':
        scaleArray = ['1', '2-', '3-', '4', '5-', '6-', '7-'];
        break;

      case 'natural minor B':
        scaleArray = ['1+', '2', '3', '4+', '5', '6', '7'];
        break;
    }
  }
}