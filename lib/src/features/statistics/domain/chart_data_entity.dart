import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_data_entity.freezed.dart';

@freezed
class ChartData with _$ChartData {
  const ChartData._();
  const factory ChartData({
    required dynamic label,
    required int value,
    required Color color,
  }) = _ChartData;
}
