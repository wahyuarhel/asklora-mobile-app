import 'package:onfido_sdk/onfido_sdk.dart';

Future<List<OnfidoResult>> startOnfido(String applicantToken) async {
  final Onfido onfido = Onfido(
    sdkToken: applicantToken,
    // Hide enterprise feature as it is throwing exception.
    /*enterpriseFeatures: EnterpriseFeatures(
      hideOnfidoLogo: _hideOnfidoLogo,
    ),*/
  );

  final response = await onfido.start(
    flowSteps: FlowSteps(
      proofOfAddress: false,
      welcome: false,
      documentCapture: DocumentCapture(
          documentType: DocumentType.nationalIdentityCard,
          countryCode: CountryCode.HKG),
      faceCapture: FaceCapture.photo(),
    ),
  );

  return response;
}
