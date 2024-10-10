import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterButtons extends StatefulWidget {
  final Function(bool, bool) onFilterChanged;

  const FilterButtons({required this.onFilterChanged, super.key});

  @override
  State<FilterButtons> createState() => _FilterButtonsState();
}

class _FilterButtonsState extends State<FilterButtons> {
  bool _isVegSelected = false;
  bool _isNonVegSelected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isVegSelected = !_isVegSelected;
              _isNonVegSelected = _isVegSelected ? false : _isNonVegSelected;
              widget.onFilterChanged(_isVegSelected, _isNonVegSelected);
            });
          },
          child: Container(
            width: 77,
            height: 32,
            decoration: BoxDecoration(
                color: _isVegSelected ? Colors.green : Colors.white,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.green)),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Veg',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: _isVegSelected ? Colors.white : Colors.green),
                ),
                const SizedBox(
                  width: 6,
                ),
                Container(
                  height: 17,
                  width: 17,
                  color: Colors.white,
                  child: SvgPicture.asset(
                    'assets/svg/veg_non-veg/veg.svg',
                    height: 16,
                    width: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isNonVegSelected = !_isNonVegSelected;
              _isVegSelected = _isNonVegSelected ? false : _isVegSelected;
              widget.onFilterChanged(_isVegSelected, _isNonVegSelected);
            });
          },
          child: Container(
            width: 117,
            height: 32,
            decoration: BoxDecoration(
                color: _isNonVegSelected ? Colors.red : Colors.white,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.red)),
            child: Center(
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Non-Veg',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: _isNonVegSelected ? Colors.white : Colors.red),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Container(
                    height: 17,
                    width: 17,
                    color: Colors.white,
                    child: SvgPicture.asset(
                      'assets/svg/veg_non-veg/non_veg.svg',
                      height: 16,
                      width: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
