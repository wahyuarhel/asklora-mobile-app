import 'package:flutter/material.dart';

import '../styles/asklora_colors.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({super.key})
      : super(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: AskLoraColors.charcoal,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
}
