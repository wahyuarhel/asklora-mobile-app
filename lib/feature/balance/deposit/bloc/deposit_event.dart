part of 'deposit_bloc.dart';

abstract class DepositEvent extends Equatable {
  const DepositEvent() : super();

  @override
  List<Object?> get props => [];
}

class DepositAmountChanged extends DepositEvent {
  final double depositAmount;

  const DepositAmountChanged(this.depositAmount) : super();

  @override
  List<Object?> get props => [depositAmount];
}

class ProofOfRemittanceImagesChanged extends DepositEvent {
  final List<PlatformFile> images;

  const ProofOfRemittanceImagesChanged(this.images) : super();

  @override
  List<Object> get props => [images];
}

class ProofOfRemittanceImageDeleted extends DepositEvent {
  final PlatformFile image;

  const ProofOfRemittanceImageDeleted(this.image) : super();

  @override
  List<Object> get props => [image];
}

class SubmitDeposit extends DepositEvent {}

class ResetDepositResponse extends DepositEvent {}
