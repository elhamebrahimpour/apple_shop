import 'package:apple_shop/data/model/variant.dart';
import 'package:apple_shop/data/model/variant_types.dart';

class ProductVaraint {
  VariantTypes variantTypes;
  List<Variant> variantList;

  ProductVaraint(this.variantTypes, this.variantList);
}
