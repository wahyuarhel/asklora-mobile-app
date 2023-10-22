import 'package:equatable/equatable.dart';

enum GroupType { today, others }

abstract class GroupedModel extends Equatable {
  final GroupType groupType;
  final String groupTitle;

  const GroupedModel({required this.groupType, required this.groupTitle});

  @override
  List<Object?> get props {
    return [groupType, groupTitle];
  }
}
