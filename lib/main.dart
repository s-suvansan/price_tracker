import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/cubits/market_cubit.dart';
import 'package:price_tracker/cubits/price_cubit.dart';
import 'package:price_tracker/screens/home_view.dart';
import 'package:price_tracker/screens/init_view.dart';
import 'package:price_tracker/services/web_socket_service.dart';

import 'cubits/asset_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<MarketCubit>(
          create: (_) => MarketCubit(),
        ),
        BlocProvider<AssetCubit>(
          create: (_) => AssetCubit(),
        ),
        BlocProvider<PriceCubit>(
          create: (_) => PriceCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<MarketCubit>().addMarketSink();
    WebSocketService.listenData(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Price Tracker',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: {HomeView.routeName: (context) => const HomeView()},
      home: const InitView(),
    );
  }

  @override
  void dispose() {
    WebSocketService.closeStreamConnection();
    super.dispose();
  }
}
