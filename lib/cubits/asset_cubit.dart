import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/market_list_model.dart';

class AssetCubit extends Cubit<List<Assets>> {
  AssetCubit() : super([]);

  SingleValueDropDownController controller = SingleValueDropDownController();

  void sortAssetsListByMarket(List<Assets> marketList, String market) {
    if (market != "") {
      emit([]);
      controller.clearDropDown();
      List<Assets> value = marketList.where((e) => e.market == market).toSet().toList();
      state.addAll(value);
      emit(state);
    }
  }
}
