import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/utils.dart';
import '../../domain/upgrade_account/proofs_of_address_request.dart';
import '../../domain/upgrade_account/residence_info_request.dart';
import '../../utils/kyc_dropdown_enum.dart';

part 'address_proof_event.dart';

part 'address_proof_state.dart';

class AddressProofBloc extends Bloc<AddressProofEvent, AddressProofState> {
  AddressProofBloc() : super(const AddressProofState()) {
    on<AddressLine1Changed>(_onAddressLine1Changed);
    on<AddressLine2Changed>(_onAddressLine2Changed);
    on<DistrictChanged>(_onDistrictChanged);
    on<RegionChanged>(_onRegionChanged);
    on<ImagesChanged>(_onImagesChanged);
    on<ImageDeleted>(_onImageDeleted);
    on<InitiateAddressProof>(_onInitiateAddressProof);
  }

  _onInitiateAddressProof(
      InitiateAddressProof event, Emitter<AddressProofState> emit) async {
    emit(
      state.copyWith(
        addressLine1: event.residenceInfoRequest?.addressLine1,
        addressLine2: event.residenceInfoRequest?.addressLine2,
        district:
            District.findByString(event.residenceInfoRequest?.district ?? ''),
        region: Region.findByString(event.residenceInfoRequest?.region ?? ''),
        addressProofImages: event.proofOfAddressRequests != null
            ? await Future.wait(event.proofOfAddressRequests!.map(
                (e) async => await decodeBase64ToPlatformFile(e.proofFile!)))
            : [],
      ),
    );
  }

  _onAddressLine1Changed(
      AddressLine1Changed event, Emitter<AddressProofState> emit) {
    emit(state.copyWith(addressLine1: event.unitNumber));
  }

  _onAddressLine2Changed(
      AddressLine2Changed event, Emitter<AddressProofState> emit) {
    emit(state.copyWith(addressLine2: event.residentialAddress));
  }

  _onDistrictChanged(DistrictChanged event, Emitter<AddressProofState> emit) {
    emit(state.copyWith(district: event.district));
  }

  _onRegionChanged(RegionChanged event, Emitter<AddressProofState> emit) {
    emit(state.copyWith(region: event.region));
  }

  _onImagesChanged(ImagesChanged event, Emitter<AddressProofState> emit) {
    List<PlatformFile> images = List.from(state.addressProofImages);
    if (images.length > AddressProofState.maximumProofOfAddressImagesAllowed) {
      emit(state.copyWith(
          proofOfAddressImagesErrorText:
              'Maximum number of images allowed is ${AddressProofState.maximumProofOfAddressImagesAllowed}'));
    } else {
      images.addAll(event.images);
      emit(state.copyWith(
          addressProofImages: images, proofOfAddressImagesErrorText: ''));
    }
  }

  _onImageDeleted(ImageDeleted event, Emitter<AddressProofState> emit) {
    List<PlatformFile> images = List.from(state.addressProofImages);
    if (images.length > AddressProofState.maximumProofOfAddressImagesAllowed) {
      emit(state.copyWith(
          proofOfAddressImagesErrorText:
              'Maximum number of images allowed is ${AddressProofState.maximumProofOfAddressImagesAllowed}'));
    } else {
      images.remove(event.image);
      emit(state.copyWith(
          addressProofImages: images, proofOfAddressImagesErrorText: ''));
    }
  }
}
