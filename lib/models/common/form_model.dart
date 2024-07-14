import 'package:flutter/material.dart';

class FormModel {
  final String label;
  final TextInputType? keyboardType;
  final String type;
  final String key;
  final List<FormModel>? next;

  FormModel({
    required this.label,
    required this.type,
    this.keyboardType,
    required this.key,
    this.next,
  });

  // Factory method to create a FormModel from a map
  factory FormModel.fromMap(Map<String, dynamic> map) {
    return FormModel(
      label: map['label'] as String,
      keyboardType: map['keyboardType'] as TextInputType,
      type: map['type'] as String,
      key: map['key'] as String,
      next: map['next'] as List<FormModel>,
    );
  }
}
