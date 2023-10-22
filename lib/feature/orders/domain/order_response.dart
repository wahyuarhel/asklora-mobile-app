import 'package:json_annotation/json_annotation.dart';

import 'legs.dart';

part 'order_response.g.dart';

@JsonSerializable()
class OrderResponse {
  final String? id;
  @JsonKey(name: 'client_order_id')
  final String? clientOrderId;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'submitted_at')
  final String? submittedAt;
  @JsonKey(name: 'filled_at')
  final String? filledAt;
  @JsonKey(name: 'expired_at')
  final String? expiredAt;
  @JsonKey(name: 'canceled_at')
  final String? canceledAt;
  @JsonKey(name: 'failed_at')
  final String? failedAt;
  @JsonKey(name: 'replaced_at')
  final String? replacedAt;
  @JsonKey(name: 'replaced_by')
  final String? replacedBy;
  final String? replaces;
  @JsonKey(name: 'asset_id')
  final String? assetId;
  final String? symbol;
  @JsonKey(name: 'asset_class')
  final String? assetClass;
  final String? notional;
  final String? qty;
  @JsonKey(name: 'filled_qty')
  final String? filledQty;
  @JsonKey(name: 'filled_avg_price')
  final String? filledAvgPrice;
  @JsonKey(name: 'order_class')
  final String? orderClass;
  @JsonKey(name: 'order_type')
  final String? orderType;
  final String? type;
  final String? side;
  @JsonKey(name: 'time_in_force')
  final String? timeInForce;
  @JsonKey(name: 'limit_price')
  final String? limitPrice;
  @JsonKey(name: 'stop_price')
  final String? stopPrice;
  final String? status;
  @JsonKey(name: 'extended_hours')
  final String? extendedHours;
  final Legs? legs;
  @JsonKey(name: 'trail_percent')
  final String? trailPercent;
  @JsonKey(name: 'trail_price')
  final String? trailPrice;
  final String? hwm;
  final String? commission;

  OrderResponse(
      {this.id,
      this.clientOrderId,
      this.createdAt,
      this.updatedAt,
      this.submittedAt,
      this.filledAt,
      this.expiredAt,
      this.canceledAt,
      this.failedAt,
      this.replacedAt,
      this.replacedBy,
      this.replaces,
      this.assetId,
      this.symbol,
      this.assetClass,
      this.notional,
      this.qty,
      this.filledQty,
      this.filledAvgPrice,
      this.orderClass,
      this.orderType,
      this.type,
      this.side,
      this.timeInForce,
      this.status,
      this.extendedHours,
      this.legs,
      this.trailPercent,
      this.trailPrice,
      this.hwm,
      this.commission,
      this.stopPrice,
      this.limitPrice});

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
