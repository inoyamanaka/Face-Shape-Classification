import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final String message;
  const ImageEntity({required this.message});

  @override
  List<Object?> get props => [message];
}

class DataImageEntity extends Equatable {
  final List<String>? urls;
  final String? bentukWajah;
  final double? persentase;

  const DataImageEntity(
      {required this.urls,
      required this.bentukWajah,
      required this.persentase});

  @override
  List<Object?> get props => [urls, bentukWajah, persentase];
}
