import 'package:ecommerce_sqflite/common/shared_code.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DropDownTextField extends StatelessWidget {
  DropDownTextField({
    super.key,
    required this.items,
    required this.onChanged,
    required this.title,
    this.enabled = true,
    this.hintText,
    this.notifFilter,
    this.value,
    this.nullValue,
  });

  final List<String> items;
  final String? value;
  final ValueChanged? onChanged;
  final String? title;
  String? hintText;
  bool? enabled;
  bool? notifFilter;
  String? nullValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!, style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(
          height: 1.h,
        ),
        _buildDropDownForm(context),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }

  Widget _buildDropDownForm(BuildContext context) {
    return DropdownButtonFormField<String>(
      onChanged: onChanged,
      style: enabled == true
          ? Theme.of(context).textTheme.bodyMedium
          : Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black.withOpacity(0.2)),
      enableFeedback: enabled,
      borderRadius: BorderRadius.circular(5),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.black.withOpacity(0.2)),
        contentPadding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 14.sp),
      ),
      value: value ?? nullValue,
      items: items.map(
        (e) {
          return DropdownMenuItem<String>(
            value: e,
            child: SizedBox(
              child: Text(
                e.length > 35 ? '${e.substring(0, 35)}...' : e,
              ),
            ),
          );
        },
      ).toList(),
      validator: (value) {
        // Ensure the dropdown value is not empty
        return SharedCode(context).emptyValidator(value);
      },
    );
  }
}