part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class InitiateNotification extends NotificationEvent {}

class AllowInAppNotification extends NotificationEvent {
  final bool isAllowInAppNotification;

  const AllowInAppNotification(this.isAllowInAppNotification);

  @override
  List<Object> get props => [isAllowInAppNotification];
}

class AllowPushNotification extends NotificationEvent {
  final bool isAllowPushNotification;

  const AllowPushNotification(this.isAllowPushNotification);

  @override
  List<Object> get props => [isAllowPushNotification];
}

class AllowEmailNotification extends NotificationEvent {
  final bool isAllowEmailNotification;

  const AllowEmailNotification(this.isAllowEmailNotification);

  @override
  List<Object> get props => [isAllowEmailNotification];
}
