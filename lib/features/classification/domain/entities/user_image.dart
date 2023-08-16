import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final List<String> urls;
  final String bentukWajah;
  final double persentase;

  ImageEntity(this.urls, this.bentukWajah, this.persentase);

  @override
  // TODO: implement props
  List<Object?> get props => [urls, bentukWajah, persentase];
}
