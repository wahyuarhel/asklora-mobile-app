import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../repository/file_picker_repository.dart';
import '../styles/asklora_colors.dart';
import '../styles/asklora_text_styles.dart';
import '../utils/app_icons.dart';
import 'custom_text_new.dart';
import 'dotted_border/dotted_border.dart';

class CustomImagePicker extends StatelessWidget {
  final bool disabled;
  final bool disabledPick;
  final String? title;
  final Color titleColor;
  final String hintText;
  final List<PlatformFile> initialValue;
  final String? additionalText;
  final Function(List<PlatformFile>)? onImagePicked;
  final Function(PlatformFile)? onImageDeleted;
  final bool allowMultiple;
  final FilePickerRepository filePickerRepository = FilePickerRepository();

  CustomImagePicker(
      {this.title,
      this.hintText = '',
      this.initialValue = const [],
      this.titleColor = AskLoraColors.charcoal,
      this.additionalText,
      this.onImagePicked,
      this.onImageDeleted,
      this.disabled = false,
      this.allowMultiple = true,
      this.disabledPick = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          CustomTextNew(
            title!,
            style: AskLoraTextStyles.body2.copyWith(color: titleColor),
          ),
        const SizedBox(
          height: 6,
        ),
        initialValue.isEmpty ? _emptyImage() : _haveImages(context),
        if (additionalText != null)
          Padding(
            padding: const EdgeInsets.only(top: 13),
            child: CustomTextNew(
              additionalText!,
              style: AskLoraTextStyles.body3
                  .copyWith(color: AskLoraColors.charcoal),
            ),
          )
      ],
    );
  }

  Widget _haveImages(BuildContext context) {
    double spacing = 12;
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth / 2 - spacing / 2;
        return Align(
          alignment: disabled ? Alignment.centerLeft : Alignment.center,
          child: Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              ...initialValue
                  .map((e) => Container(
                        padding: const EdgeInsets.all(6),
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: AskLoraColors.gray,
                                blurRadius: 5.0,
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xffc2d1d9),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(e.path ?? '/')))),
                        child: disabled
                            ? const SizedBox.shrink()
                            : Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    if (onImageDeleted != null && !disabled) {
                                      onImageDeleted!(e);
                                    }
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: AskLoraColors.darkGray,
                                    shadows: [
                                      Shadow(
                                        color: AskLoraColors.gray,
                                        blurRadius: 5.0,
                                        offset: Offset(1, 4),
                                      )
                                    ],
                                  ),
                                )),
                      ))
                  .toList(),
              if (!disabled) _emptyImage(width: size, height: size)
            ],
          ),
        );
      },
    );
  }

  Widget _emptyImage({double width = double.infinity, double? height}) =>
      DottedBorder(
          borderType: BorderType.rRect,
          radius: const Radius.circular(5),
          color: Colors.grey,
          dashPattern: const [4, 4],
          child: Container(
            width: width - 4,
            height: height != null ? height - 4 : null,
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (onImagePicked != null && !disabled && !disabledPick) {
                      if (allowMultiple) {
                        onImagePicked!(await filePickerRepository.pickFiles(
                            fileType: FileType.image));
                      } else {
                        final file = await filePickerRepository.pickFile(
                            fileType: FileType.image);
                        if (file != null) {
                          onImagePicked!([file]);
                        }
                      }
                    }
                  },
                  child: getSvgIcon('icon_add_files',
                      color: disabledPick ? AskLoraColors.gray : null),
                ),
                if (hintText.isNotEmpty && initialValue.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CustomTextNew(
                      hintText,
                      style: AskLoraTextStyles.body1
                          .copyWith(color: AskLoraColors.gray),
                    ),
                  ),
              ],
            ),
          ));
}
