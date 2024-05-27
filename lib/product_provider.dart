import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'settings_provider.dart';

final productProvider = StateNotifierProvider<ProductNotifier, List<String>>((ref) {
  return ProductNotifier(ref.watch(settingsProvider));
});

class ProductNotifier extends StateNotifier<List<String>> {
  UserSettings settings;

  ProductNotifier(this.settings) : super([]) {
    _updateProductList();
  }

  void _updateProductList() {
    List<String> productList = settings.language == 'English'
        ? ["Apple", "Banana", "Cherry", "Orange", "Peach", "Grape"]
        : ["りんご", "ばなな", "さくらんぼ", "みかん", "もも", "ぶどう"];

    state = productList;
  }

  void search(String query) {
    _updateProductList();
    if (query.isNotEmpty) {
      state = state
          .where(
              (product) => product.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
