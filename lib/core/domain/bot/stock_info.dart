import '../../../core/utils/date_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'stock_info.g.dart';

@JsonSerializable()
class StockInfo extends Equatable {
  final String symbol;
  @JsonKey(name: 'ticker_name')
  final String tickerName;
  @JsonKey(name: 'chinese_name')
  final String chineseName;
  @JsonKey(name: 'traditional_name')
  final String traditionalName;
  final String description;
  final String sector;
  final String industry;
  final String ceo;
  final int employees;
  final String headquarter;
  final String founded;

  String get foundedFormatted =>
      formatDateTimeAsString(founded, dateFormat: 'dd/MM/yyyy');

  const StockInfo(
      this.symbol,
      this.tickerName,
      this.chineseName,
      this.traditionalName,
      this.description,
      this.sector,
      this.industry,
      this.ceo,
      this.employees,
      this.headquarter,
      this.founded);

  factory StockInfo.fromJson(Map<String, dynamic> json) =>
      _$StockInfoFromJson(json);

  Map<String, dynamic> toJson() => _$StockInfoToJson(this);

  @override
  List<Object?> get props => [
        symbol,
        tickerName,
        chineseName,
        traditionalName,
        description,
        sector,
        industry,
        ceo,
        employees,
        headquarter,
        founded
      ];
}
