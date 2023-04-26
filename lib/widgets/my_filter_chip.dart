import 'filter_chip_data.dart';
import 'package:flutter/material.dart';

class FilterChips {
  static final all = <FilterChipData>[
    FilterChipData(
      label: 'Academic',
      isSelected: false,
      color: Colors.green,
    ),
    FilterChipData(
      label: 'Financial',
      isSelected: false,
      color: Colors.red,
    ),
    FilterChipData(
      label: 'Depression',
      isSelected: false,
      color: Colors.blue,
    ),
    FilterChipData(
      label: 'Social problems',
      isSelected: false,
      color: Colors.orange,
    ),
    FilterChipData(
      label: 'Others',
      isSelected: false,
      color: Colors.purple,
    ),
  ];
}
