import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/models/market_list_model.dart';
import 'package:web_socket_channel/io.dart';

import '../cubits/market_cubit.dart';
import '../cubits/price_cubit.dart';
import '../models/price_model.dart';

class WebSocketService {
  static const String webSocketUrl = 'wss://ws.binaryws.com/websockets/v3?app_id=1089';
  static late StreamSubscription subscription;
  static final _channel = IOWebSocketChannel.connect(
    Uri.parse(webSocketUrl),
  );

  static void addSink(Object? object) {
    _channel.sink.add(jsonEncode(object));
  }

  static void listenData(BuildContext context) {
    try {
      subscription = _channel.stream.listen((data) {
        if (data != null) {
          Map<String, dynamic> result = jsonDecode(data);
          if (result["msg_type"] == MessageTypes.activeSymbols.msgType) {
            MarketListModel marketList = MarketListModel.fromJson(result);
            context.read<MarketCubit>().setMarkets(marketList.activeSymbols);
          } else if (result["msg_type"] == MessageTypes.tick.msgType) {
            PriceModel priceModel = PriceModel.fromJson(result);
            context.read<PriceCubit>().setPrice(priceModel);
          } else if (result["msg_type"] == MessageTypes.forget.msgType) {
            debugPrint(result["forget"].toString());
          }
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static void closeStreamConnection() {
    subscription.cancel();
    _channel.sink.close();
  }
}

enum MessageTypes {
  activeSymbols("active_symbols"),
  tick("tick"),
  forget("forget");

  final String msgType;
  const MessageTypes(this.msgType);
}
