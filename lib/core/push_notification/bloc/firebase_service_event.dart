part of 'firebase_service_bloc.dart';

abstract class FirebaseServiceEvent extends Equatable {
  const FirebaseServiceEvent();
}

class InitFirebase extends FirebaseServiceEvent {
  @override
  List<Object?> get props => [];
}
