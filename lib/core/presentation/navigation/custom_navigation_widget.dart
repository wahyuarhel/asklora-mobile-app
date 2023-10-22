import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../values/app_values.dart';
import '../custom_text.dart';
import 'bloc/navigation_bloc.dart';

class CustomNavigationWidget<T> extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? navigationButton;
  final bool disableButton;
  final Function? onSubmit;
  final Function? onBackPressed;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsets padding;
  final Widget? header;

  const CustomNavigationWidget(
      {required this.child,
      this.onSubmit,
      this.disableButton = true,
      this.navigationButton,
      this.title = '',
      this.onBackPressed,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.header,
      this.padding = AppValues.screenHorizontalPadding,
      Key? key})
      : super(key: key);

  void _onTapBack(BuildContext context) {
    if (onBackPressed != null) {
      onBackPressed!();
    } else {
      context.read<NavigationBloc<T>>().add(const PagePop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onTapBack(context);
        return false;
      },
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header ??
                Material(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () => _onTapBack(context),
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Icon(
                              Icons.arrow_back_rounded,
                              size: 26,
                              color: Colors.black,
                            ),
                          )),
                      if (title.isNotEmpty)
                        Expanded(
                          child: CustomText(
                            title,
                            type: FontType.h3,
                            color: Colors.black,
                          ),
                        )
                    ],
                  ),
                ),
            Expanded(
              child: Padding(
                padding: padding,
                child: Container(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  child: child,
                ),
              ),
            ),
            navigationButton ?? const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
