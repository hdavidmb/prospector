import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistic_entity.freezed.dart';

@freezed
class Statistic with _$Statistic {
  @Assert('newStatus != null || oldStatus != null',
      'At least newStatus or olStatus should have a non null value')
  @Assert('newListCount != null || oldListCount != null',
      'At least newListCount or oldListCount should have a non null value')
  const factory Statistic({
    required String id,
    required String contactID,
    required String userID,
    required DateTime created,
    String? newStatus,
    int? newListCount,
    String? oldStatus,
    int? oldListCount,
    String? company,
  }) = _Statistic;

  const Statistic._();

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> statisticMap = {
      'id': id,
      'contact_id': contactID,
      'user_id': userID,
      'created': created,
    };
    if (newStatus != null) statisticMap['new_status'] = newStatus;
    if (newListCount != null) statisticMap['new_list_count'] = newListCount;
    if (oldStatus != null) statisticMap['old_status'] = oldStatus;
    if (oldListCount != null) statisticMap['old_list_count'] = oldListCount;
    if (company != null) statisticMap['company'] = company;
    return statisticMap;
  }

  factory Statistic.fromMap(Map<String, dynamic> map) {
    return Statistic(
      id: map['id'] as String,
      contactID: map['contact_id'] as String,
      userID: map['user_id'] as String,
      created: map['created'] as DateTime,
      newStatus: map['new_status'] as String?,
      newListCount: map['new_list_count'] as int?,
      oldStatus: map['old_status'] as String?,
      oldListCount: map['old_list_count'] as int?,
      company: map['company'] as String?,
    );
  }

  factory Statistic.empty() => Statistic(
      id: '',
      contactID: '',
      userID: '',
      created: DateTime.now(),
      newListCount: 0,
      newStatus: '');
}

extension StatisticX on Statistic {
  bool get isEmpty => id == '';
  bool get isNotEmpty => id != '';
}
