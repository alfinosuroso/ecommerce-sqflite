// ignore: file_names
import 'package:ecommerce_sqflite/common/shared_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final bool? obsecure;
  final bool? readOnly;
  final VoidCallback? onTap;
  final Function? onTapImage;
  final VoidCallback? onEditingCompleted;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator, onChanged;
  final bool? isMulti;
  final bool? autofocus;
  final bool? enabled;
  final String? errorText;
  final String? helperText;
  final Widget? suffix;
  final Widget? prefix;
  final String? hintText;
  final String? title;
  final String? currentValue;
  final String? assetImage;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final bool? isDropDown;
  final bool? isDateForm;
  final bool? isTimeForm;
  final bool? isUploadImage;
  final bool? isCostForm;
  final bool? uploadFile;
  final bool? editFile;
  final bool? isTitle;
  final bool? isFlag;
  final bool alwaysValidate;
  final List<DropdownMenuItem<String>>? customDropdownItems;
  final String? customSelectedValue;

  const CustomTextFormField(
      {this.controller,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.obsecure = false,
      this.onTap,
      this.onTapImage,
      this.isMulti = false,
      this.readOnly = false,
      this.autofocus = false,
      this.errorText,
      this.helperText,
      this.suffix,
      this.prefix,
      this.enabled = true,
      this.onEditingCompleted,
      this.onChanged,
      this.hintText,
      required this.title,
      this.currentValue,
      this.assetImage = 'assets/images/ktp-sample.png',
      this.inputFormatters,
      // dua node ini nanti di-required
      this.nextFocusNode,
      this.focusNode,
      this.isDropDown = false,
      this.isDateForm = false,
      this.isTimeForm = false,
      this.isUploadImage = false,
      this.isCostForm = false,
      this.uploadFile = false,
      this.editFile = false,
      this.isTitle = true,
      this.isFlag = false,
      this.alwaysValidate = false,
      this.customDropdownItems,
      this.customSelectedValue,
      super.key});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null || widget.title == ""
            ? Text(widget.title!, style: Theme.of(context).textTheme.bodyMedium)
            : const SizedBox(height: 0),
        widget.title != null || widget.title == ""
            ? SizedBox(height: 1.h)
            : const SizedBox(height: 0),
        _buildRegularTextForm(context),
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget _buildRegularTextForm(context) {
    dynamic validator = widget.validator;
    validator ??= SharedCode(context).emptyValidator;
    return TextFormField(
      style: widget.enabled == true
          ? Theme.of(context).textTheme.bodyMedium
          : Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black.withOpacity(0.2)),
      // onFieldSubmitted: (_) => widget.nextFocusNode?.requestFocus(),
      onChanged: widget.onChanged,
      initialValue: widget.currentValue,
      onEditingComplete: widget.onEditingCompleted,
      autofocus: widget.autofocus!,
      minLines: widget.isMulti! ? 5 : 1,
      maxLines: widget.isMulti! ? null : 1,
      onTap: widget.onTap,
      enabled: widget.enabled,
      readOnly: widget.readOnly!,
      obscureText: widget.obsecure!,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      // inputFormatters: [FilteringTextInputFormatter.allow(filterPattern)],
      decoration: InputDecoration(
        errorText: widget.errorText,
        prefixIcon: widget.prefix,
        suffixIcon: widget.suffix,
        hintText: widget.hintText,
        helperText: widget.helperText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.black.withOpacity(0.2)),
        contentPadding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 14.sp),
      ),
      validator: widget.validator ?? validator,
      autovalidateMode: widget.alwaysValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
    );
  }
}
