import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/price_model.dart';
import '../services/web_socket_service.dart';

class PriceCubit extends Cubit<PriceState> {
  PriceCubit() : super(const PriceInitial());

  PriceModel? _price;

  void addPriceSink(String ticks) {
    addForgetSink(isLoading: true);
    WebSocketService.addSink({"ticks": ticks, "subscribe": 1});
  }

  void addForgetSink({bool isLoading = false}) {
    isLoading ? emit(const PriceLoading()) : emit(const PriceInitial());
    if (_price?.subscription?.id != null) {
      WebSocketService.addSink({"forget": _price?.subscription?.id});
      _price = null;
    }
  }

  void setPrice(PriceModel price) {
    if (price.tick?.quote != null) {
      Color priceColor = setPriceColor(price);
      _price = price;
      emit(PriceLoaded(price, priceColor));
    } else {
      _price = null;
      emit(PriceError(price.error));
    }
  }

  Color setPriceColor(PriceModel price) {
    Color priceColor = Colors.grey;
    if (_price?.tick?.quote != null) {
      if (price.tick!.quote! < _price!.tick!.quote!) {
        priceColor = Colors.red;
      } else if (price.tick!.quote! > _price!.tick!.quote!) {
        priceColor = Colors.green;
      } else if (price.tick!.quote! == _price!.tick!.quote!) {
        priceColor = Colors.grey;
      }
    }
    return priceColor;
  }
}

abstract class PriceState {
  const PriceState();
}

class PriceInitial extends PriceState {
  const PriceInitial();
}

class PriceLoading extends PriceState {
  const PriceLoading();
}

class PriceLoaded extends PriceState {
  final PriceModel? price;
  final Color priceColor;
  const PriceLoaded(this.price, this.priceColor);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PriceLoaded && other.price == price;
  }

  @override
  int get hashCode => price.hashCode;
}

class PriceError extends PriceState {
  final Error? error;
  const PriceError(this.error);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PriceError && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}
