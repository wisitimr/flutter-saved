import 'package:equatable/equatable.dart';

class ColumnX extends Equatable {
  const ColumnX({
    required this.index,
    required this.text,
  });

  final int index;
  final String text;

  factory ColumnX.fromJson(Map<String, dynamic> json) => ColumnX(
        index: json['index'],
        text: json['text'],
      );

  @override
  List<Object> get props => [
        index,
        text,
      ];
}
