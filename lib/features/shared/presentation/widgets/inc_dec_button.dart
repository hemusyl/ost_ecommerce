import 'package:flutter/material.dart';
import 'package:ost_ecommerce/app/app_colors.dart';

class IncDecButton extends StatefulWidget {
  const IncDecButton({super.key, required this.onChange});

  final Function(int) onChange;

  @override
  State<IncDecButton> createState() => _IncDecButtonState();
}

class _IncDecButtonState extends State<IncDecButton> {
  int _currentValue = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        _buildButton(Icons.remove, () {
          if (_currentValue > 1) {
            _currentValue--;
            widget.onChange(_currentValue);
            setState(() {});
          }
        }),
        Text(
          _currentValue.toString(),
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        _buildButton(Icons.add, () {
          _currentValue++;
          widget.onChange(_currentValue);
          setState(() {});
        }),
      ],
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
