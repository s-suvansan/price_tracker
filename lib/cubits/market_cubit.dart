import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/market_list_model.dart';
import '../services/web_socket_service.dart';

class MarketCubit extends Cubit<List<Assets>> {
  MarketCubit() : super([]);

  void addMarketSink() {
    WebSocketService.addSink({"active_symbols": "brief", "product_type": "basic"});
  }

  void setMarkets(List<Assets>? value) {
    if (value != null) {
      emit(value);
    }
  }
}
