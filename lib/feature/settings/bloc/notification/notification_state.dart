part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final bool isAllowInAppNotification;
  final bool isAllowPushNotification;
  final bool isAllowEmailNotification;

  const NotificationState({
    this.isAllowInAppNotification = false,
    this.isAllowPushNotification = false,
    this.isAllowEmailNotification = false,
  });

  @override
  List<Object> get props => [
        isAllowInAppNotification,
        isAllowPushNotification,
        isAllowEmailNotification
      ];

  NotificationState copyWith({
    bool? isAllowInAppNotification,
    bool? isAllowPushNotification,
    bool? isAllowEmailNotification,
  }) {
    return NotificationState(
      isAllowInAppNotification:
          isAllowInAppNotification ?? this.isAllowInAppNotification,
      isAllowPushNotification:
          isAllowPushNotification ?? this.isAllowPushNotification,
      isAllowEmailNotification:
          isAllowEmailNotification ?? this.isAllowEmailNotification,
    );
  }
}
