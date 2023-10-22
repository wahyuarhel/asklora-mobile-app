import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../generated/l10n.dart';
import '../../../bloc/signing_agreement/signing_agreement_bloc.dart';
import '../../widgets/kyc_sub_title.dart';
import '../../widgets/summary_text_info.dart';

class SignAgreementSummaryContent extends StatelessWidget {
  final String title;

  const SignAgreementSummaryContent({Key? key, required this.title})
      : super(key: key);

  static const double _spaceHeightDouble = 20;
  final SizedBox _spaceHeight = const SizedBox(height: _spaceHeightDouble);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KycSubTitle(
            subTitle: title,
          ),
          _spaceHeight,
          SummaryTextInfo(
              title: S.of(context).askloraCustomerAgreement,
              subTitle: '(${S.of(context).agreed})'),
          _spaceHeight,
          SummaryTextInfo(
            title: S.of(context).riskDisclosureStatement,
            subTitle: '(${S.of(context).agreed})',
          ),
          _spaceHeight,
          SummaryTextInfo(
              title: S.of(context).w8benForm,
              subTitle: '(${S.of(context).agreed})'),
          _spaceHeight,
          SummaryTextInfo(
              title: 'Electronic Signature',
              subTitle: context.read<SigningAgreementBloc>().state.legalName),
        ],
      );
}
