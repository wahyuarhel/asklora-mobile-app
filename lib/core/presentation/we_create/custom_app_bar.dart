import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar.transparent({super.key})
      : super(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        );

  CustomAppBar.transparentMinimal({super.key})
      : super(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        );
}
