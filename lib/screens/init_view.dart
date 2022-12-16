import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/screens/home_view.dart';

import '../cubits/market_cubit.dart';
import '../models/market_list_model.dart';

class InitView extends StatelessWidget {
  const InitView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarketCubit, List<Assets>>(
      listener: (context, state) {
        if (state.isNotEmpty) {
          Navigator.popAndPushNamed(context, HomeView.routeName);
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
