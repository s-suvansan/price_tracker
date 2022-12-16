class MarketListModel {
  MarketListModel({
    this.activeSymbols,
  });

  List<Assets>? activeSymbols;

  factory MarketListModel.fromJson(Map<String, dynamic> json) => MarketListModel(
        activeSymbols:
            json["active_symbols"] != null ? List<Assets>.from(json["active_symbols"].map((x) => Assets.fromJson(x))) : [],
      );
}

class Assets {
  Assets({
    this.allowForwardStarting,
    this.displayName,
    this.exchangeIsOpen,
    this.isTradingSuspended,
    this.market,
    this.marketDisplayName,
    this.pip,
    this.submarket,
    this.submarketDisplayName,
    this.symbol,
    this.symbolType,
  });

  int? allowForwardStarting;
  String? displayName;
  int? exchangeIsOpen;
  int? isTradingSuspended;
  String? market;
  String? marketDisplayName;
  double? pip;
  String? submarket;
  String? submarketDisplayName;
  String? symbol;
  String? symbolType;

  factory Assets.fromJson(Map<String, dynamic> json) => Assets(
        allowForwardStarting: json["allow_forward_starting"] ?? 0,
        displayName: json["display_name"] ?? "",
        exchangeIsOpen: json["exchange_is_open"] ?? 0,
        isTradingSuspended: json["is_trading_suspended"] ?? 0,
        market: json["market"] ?? "",
        marketDisplayName: json["market_display_name"] ?? "",
        pip: json["pip"] ?? 0.0,
        submarket: json["submarket"] ?? "",
        submarketDisplayName: json["submarket_display_name"] ?? "",
        symbol: json["symbol"] ?? "",
        symbolType: json["symbol_type"] ?? "",
      );
}
