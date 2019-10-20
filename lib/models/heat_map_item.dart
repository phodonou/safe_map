import 'models.dart';
import 'package:meta/meta.dart';

class HeatMapItem {
  final String id;
  final Coordinates coordinates;
  final String itemName;
  final int dangerNumber;
  final String details;

  HeatMapItem({
    @required this.id,
    @required this.coordinates,
    @required this.itemName,
    @required this.dangerNumber,
    @required this.details,
  });
}