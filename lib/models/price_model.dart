class PriceModel {
  PriceModel({
    this.msgType,
    this.subscription,
    this.tick,
    this.error,
  });

  String? msgType;
  Subscription? subscription;
  Tick? tick;
  Error? error;

  factory PriceModel.fromJson(Map<String, dynamic> json) => PriceModel(
        msgType: json["msg_type"] ?? "",
        subscription: json["subscription"] != null ? Subscription.fromJson(json["subscription"]) : null,
        tick: json["tick"] != null ? Tick.fromJson(json["tick"]) : null,
        error: json["error"] != null ? Error.fromJson(json["error"]) : null,
      );
}

class Subscription {
  Subscription({
    this.id,
  });

  String? id;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"] ?? "",
      );
}

class Tick {
  Tick({
    this.ask,
    this.bid,
    this.epoch,
    this.id,
    this.pipSize,
    this.quote,
    this.symbol,
  });

  double? ask;
  double? bid;
  int? epoch;
  String? id;
  int? pipSize;
  double? quote;
  String? symbol;

  factory Tick.fromJson(Map<String, dynamic> json) => Tick(
        ask: json["ask"] != null ? json["ask"].toDouble() : 0.0,
        bid: json["bid"] != null ? json["bid"].toDouble() : 0.0,
        epoch: json["epoch"] ?? 0,
        id: json["id"] ?? "",
        pipSize: json["pip_size"] ?? 0,
        quote: json["quote"] != null ? json["quote"].toDouble() : 0.0,
        symbol: json["symbol"] ?? "",
      );
}

class Error {
  Error({
    this.code,
    this.details,
    this.message,
  });

  String? code;
  Details? details;
  String? message;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json["code"] ?? "",
        details: json["details"] != null ? Details.fromJson(json["details"]) : null,
        message: json["message"] ?? "",
      );
}

class Details {
  Details({
    this.field,
  });

  String? field;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        field: json["field"] ?? "",
      );
}
