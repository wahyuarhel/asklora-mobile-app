import 'package:asklora_mobile_app/feature/onboarding/kyc/bloc/address_proof/address_proof_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asklora_mobile_app/feature/onboarding/kyc/utils/kyc_dropdown_enum.dart';

void main() async {
  group('Address Proof Bloc Test', () {
    late AddressProofBloc addressProofBloc;

    setUp(() async {
      addressProofBloc = AddressProofBloc();
    });

    test(
        'init state data should be empty string except for unrequired field it should be null.',
        () {
      expect(addressProofBloc.state, const AddressProofState());
    });

    blocTest<AddressProofBloc, AddressProofState>('Input field on state',
        build: () => addressProofBloc,
        act: (bloc) => {
              bloc.add(const AddressLine1Changed('San Mateo')),
              bloc.add(const AddressLine2Changed('San Georgia')),
              bloc.add(const DistrictChanged(District.eastern)),
              bloc.add(const RegionChanged(Region.hongKongIsland)),
              bloc.add(
                  ImagesChanged([PlatformFile(name: 'some_file', size: 100)]))
            },
        expect: () => {
              const AddressProofState(
                addressLine1: 'San Mateo',
                addressLine2: '',
                district: null,
                region: null,
                addressProofImages: [],
              ),
              const AddressProofState(
                addressLine1: 'San Mateo',
                addressLine2: 'San Georgia',
                district: null,
                region: null,
                addressProofImages: [],
              ),
              const AddressProofState(
                addressLine1: 'San Mateo',
                addressLine2: 'San Georgia',
                district: District.eastern,
                region: null,
                addressProofImages: [],
              ),
              const AddressProofState(
                addressLine1: 'San Mateo',
                addressLine2: 'San Georgia',
                district: District.eastern,
                region: Region.hongKongIsland,
                addressProofImages: [],
              ),
              AddressProofState(
                addressLine1: 'San Mateo',
                addressLine2: 'San Georgia',
                district: District.eastern,
                region: Region.hongKongIsland,
                addressProofImages: [
                  PlatformFile(name: 'some_file', size: 100)
                ],
              ),
            });
    tearDown(() => {addressProofBloc.close()});
  });
}
