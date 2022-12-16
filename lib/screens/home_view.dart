import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/cubits/market_cubit.dart';

import '../cubits/asset_cubit.dart';
import '../cubits/price_cubit.dart';
import '../models/market_list_model.dart';

class HomeView extends StatelessWidget {
  static const routeName = "HomeView";
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Price Tracker"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
          child: Column(children: const [
            MarketDropDown(),
            SizedBox(height: 24.0),
            AssetDropDown(),
            SizedBox(height: 56.0),
            Price(),
          ]),
        ));
  }
}

class MarketDropDown extends StatelessWidget {
  const MarketDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketCubit, List<Assets>>(builder: (context, state) {
      return DropDownTextField(
        dropdownRadius: 0.0,
        textFieldDecoration: InputDecoration(
          hintText: "Select a Market",
          filled: true,
          fillColor: Theme.of(context).primaryColor.withOpacity(0.2),
          border: InputBorder.none,
        ),
        clearOption: false,
        dropDownList:
            state.map((e) => DropDownValueModel(name: e.marketDisplayName ?? "", value: e.market ?? "")).toSet().toList(),
        onChanged: (val) {
          context.read<PriceCubit>().addForgetSink();
          context.read<AssetCubit>().sortAssetsListByMarket(state, val.value);
        },
      );
    });
  }
}

class AssetDropDown extends StatelessWidget {
  const AssetDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetCubit, List<Assets>>(
      builder: (context, state) {
        return DropDownTextField(
          singleController: context.read<AssetCubit>().controller,
          dropdownRadius: 0.0,
          textFieldDecoration: InputDecoration(
            hintText: "Select a Asset",
            filled: true,
            fillColor: Theme.of(context).primaryColor.withOpacity(0.2),
            border: InputBorder.none,
          ),
          clearOption: false,
          dropDownList: state.map((e) => DropDownValueModel(name: e.displayName ?? "", value: e.symbol ?? "")).toSet().toList(),
          onChanged: (val) {
            context.read<PriceCubit>().addPriceSink(val.value);
          },
        );
      },
    );
  }
}

class Price extends StatelessWidget {
  const Price({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceCubit, PriceState>(builder: (context, state) {
      if (state is PriceLoaded) {
        return Text(
          "Price ${state.price?.tick?.quote}",
          style: TextStyle(
            color: state.priceColor,
            fontSize: 20.0,
          ),
        );
      } else if (state is PriceLoading) {
        return const CircularProgressIndicator();
      } else if (state is PriceError) {
        return Text(
          "${state.error?.message}",
          style: const TextStyle(
            color: Colors.redAccent,
            fontSize: 20.0,
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
