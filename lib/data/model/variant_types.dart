class VariantTypes {
  String id;
  String name;
  String title;
  VariantTypesEnum type;

  VariantTypes(this.id, this.name, this.title, this.type);

  factory VariantTypes.fromJson(Map<String, dynamic> jsonObject) {
    return VariantTypes(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['title'],
      _getVariantTypeEnum(jsonObject['type']),
    );
  }
}

VariantTypesEnum _getVariantTypeEnum(String type) {
  switch (type) {
    case 'Color':
      return VariantTypesEnum.color;
    case 'Storage':
      return VariantTypesEnum.storage;
    case 'Voltage':
      return VariantTypesEnum.voltage;
    default:
      return VariantTypesEnum.color;
  }
}

enum VariantTypesEnum { color, storage, voltage }
