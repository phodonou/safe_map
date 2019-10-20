import 'models.dart';

class HeatMapItem {
  final Coordinates coordinates;
  final String itemName;
  final int dangerNumber;
  final String details;

  HeatMapItem({
    this.coordinates,
    this.itemName,
    this.dangerNumber,
    this.details,
  });
}