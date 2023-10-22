part of 'firebase_service_bloc.dart';

abstract class FirebaseServiceState extends Equatable {
  const FirebaseServiceState();
}

class FirebaseServiceInitiate extends FirebaseServiceState {
  @override
  List<Object> get props => [];
}
