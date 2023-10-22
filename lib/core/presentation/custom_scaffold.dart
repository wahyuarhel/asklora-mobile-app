import 'package:flutter/material.dart';
import '../styles/asklora_colors.dart';

class CustomScaffold extends Scaffold {
  CustomScaffold(
      {super.key,
      required Widget body,
      VoidCallback? onTapBack,
      bool enableBackNavigation = true,
      bool useSafeArea = true,
      Color? appBarBackgroundColor,
      super.backgroundColor = Colors.white,
      super.bottomNavigationBar})
      : super(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: appBarBackgroundColor ?? Colors.white,
              elevation: 0.0,
              toolbarHeight: 0.0, // Hide the AppBar
            ),
            body: Stack(
              children: [
                useSafeArea ? SafeArea(child: body) : body,
                SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 10),
                  child: enableBackNavigation
                      ? Builder(
                          builder: (BuildContext context) {
                            return IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: AskLoraColors.charcoal,
                              ),
                              onPressed: () {
                                if (onTapBack != null) {
                                  onTapBack();
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                            );
                          },
                        )
                      : null,
                )),
              ],
            ));
}
