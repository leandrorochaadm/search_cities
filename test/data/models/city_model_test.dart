import 'package:flutter_test/flutter_test.dart';
import 'package:searchcities/data/models/models.dart';

void main() {
  group('CityModel.fromJson', () {
    test('should parse valid JSON correctly', () {
      // Arrange
      final json = {
        "municipio-id": 1,
        "municipio-nome": "City 1",
        "microrregiao-nome": "Microregion 1",
        "mesorregiao-nome": "Mesoregion 1",
        "UF-sigla": "UF1",
        "UF-nome": "State 1",
      };

      // Act
      final model = CityModel.fromJson(json);

      // Assert
      expect(model.cityId, 1);
      expect(model.cityName, 'City 1');
      expect(model.microregion, 'Microregion 1');
      expect(model.mesoregion, 'Mesoregion 1');
      expect(model.saAcronym, 'UF1');
      expect(model.saName, 'State 1');
    });

    test('should handle missing fields gracefully', () {
      // Arrange
      final Map<String, dynamic> json = {};

      // Act
      final model = CityModel.fromJson(json);

      // Assert
      expect(model.cityId, 0);
      expect(model.cityName, '');
      expect(model.microregion, '');
      expect(model.mesoregion, '');
      expect(model.saAcronym, '');
      expect(model.saName, '');
    });

    test('should handle partial JSON data correctly', () {
      // Arrange
      final json = {
        "municipio-id": 5,
        "municipio-nome": "Partial City",
        "UF-nome": "Partial State",
      };

      // Act
      final model = CityModel.fromJson(json);

      // Assert
      expect(model.cityId, 5);
      expect(model.cityName, 'Partial City');
      expect(model.microregion, '');
      expect(model.mesoregion, '');
      expect(model.saAcronym, '');
      expect(model.saName, 'Partial State');
    });

    test('should convert to CityEntity correctly', () {
      // Arrange
      final model = CityModel(
        cityId: 1,
        cityName: "City 1",
        microregion: "Microregion 1",
        mesoregion: "Mesoregion 1",
        saAcronym: "UF1",
        saName: "State 1",
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.cityId, model.cityId);
      expect(entity.cityName, model.cityName);
      expect(entity.microregion, model.microregion);
      expect(entity.mesoregion, model.mesoregion);
      expect(entity.saAcronym, model.saAcronym);
      expect(entity.saName, model.saName);
    });
  });
}
