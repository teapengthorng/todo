import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TodoModel extends Equatable {
  final String title;

  const TodoModel({
    required this.title,
  });

  TodoModel copyWith({
    String? title,
  }) {
    return TodoModel(
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      title: map['title'] as String,
    );
  }

  @override
  List<Object?> get props => [
        title,
      ];
}
