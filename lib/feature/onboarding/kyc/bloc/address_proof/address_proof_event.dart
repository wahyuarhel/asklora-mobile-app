part of 'address_proof_bloc.dart';

abstract class AddressProofEvent extends Equatable {
  const AddressProofEvent();

  @override
  List<Object> get props => [];
}

class AddressLine1Changed extends AddressProofEvent {
  final String unitNumber;

  const AddressLine1Changed(this.unitNumber) : super();

  @override
  List<Object> get props => [unitNumber];
}

class AddressLine2Changed extends AddressProofEvent {
  final String residentialAddress;

  const AddressLine2Changed(this.residentialAddress) : super();

  @override
  List<Object> get props => [residentialAddress];
}

class DistrictChanged extends AddressProofEvent {
  final District district;

  const DistrictChanged(this.district) : super();

  @override
  List<Object> get props => [district];
}

class RegionChanged extends AddressProofEvent {
  final Region region;

  const RegionChanged(this.region) : super();

  @override
  List<Object> get props => [region];
}

class ImagesChanged extends AddressProofEvent {
  final List<PlatformFile> images;

  const ImagesChanged(this.images) : super();

  @override
  List<Object> get props => [images];
}

class ImageDeleted extends AddressProofEvent {
  final PlatformFile image;

  const ImageDeleted(this.image) : super();

  @override
  List<Object> get props => [image];
}

class InitiateAddressProof extends AddressProofEvent {
  final ResidenceInfoRequest? residenceInfoRequest;
  final List<ProofsOfAddressRequest>? proofOfAddressRequests;
  const InitiateAddressProof(
      this.residenceInfoRequest, this.proofOfAddressRequests);

  @override
  List<Object> get props =>
      [residenceInfoRequest ?? '', proofOfAddressRequests ?? ''];
}
