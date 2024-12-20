import 'package:flutter_test/flutter_test.dart';
import 'package:searchcities/data/models/models.dart';

void main() {
  group('RegionModel.fromJson', () {
    test('should parse valid JSON correctly', () {
      // Arrange
      final json = {"id": 1, "sigla": "UF1", "nome": "Region 1"};

      // Act
      final model = RegionModel.fromJson(json);

      // Assert
      expect(model.id, 1);
      expect(model.acronym, 'UF1');
      expect(model.name, 'Region 1');
    });

    test('should handle missing fields gracefully', () {
      // Arrange
      final Map<String, dynamic> json = {};

      // Act
      final model = RegionModel.fromJson(json);

      // Assert
      expect(model.id, 0);
      expect(model.acronym, '');
      expect(model.name, '');
    });
  });
}
