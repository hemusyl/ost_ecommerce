import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({super.key, required this.sizes, required this.onSelected});

  final List<String> sizes;
  final Function(String) onSelected;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  String? _selectedSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: widget.sizes.map((size) {
        return GestureDetector(
          onTap: () {
            _selectedSize = size;
            widget.onSelected(size);
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: _selectedSize == size ? AppColors.themeColor : null,
                border: Border.all(
                    color: Colors.grey
                ),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Text(size, style: TextStyle(
              color: _selectedSize == size ? Colors.white : null,
            ),),
          ),
        );
      }).toList(),
    );
  }
}