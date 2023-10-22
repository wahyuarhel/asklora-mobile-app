import 'package:flutter/material.dart';

import '../styles/asklora_text_styles.dart';
import 'custom_text_new.dart';

Future<void> customModalBottomSheet(BuildContext context,
    {required String title, required Widget content}) {
  return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) => FractionallySizedBox(
            heightFactor: 0.9,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CustomTextNew(
                            title,
                            style: AskLoraTextStyles.h5,
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(Icons.close)))
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: const ScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: content,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
}
