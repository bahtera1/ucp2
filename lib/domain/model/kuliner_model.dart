// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Kuliner {
  final String namakuliner;
  final String notelepon;
  final String alamat;
  final String gambar;
  Kuliner({
    required this.namakuliner,
    required this.notelepon,
    required this.alamat,
    required this.gambar,
  });

  Kuliner copyWith({
    String? namakuliner,
    String? notelepon,
    String? alamat,
    String? gambar,
  }) {
    return Kuliner(
      namakuliner: namakuliner ?? this.namakuliner,
      notelepon: notelepon ?? this.notelepon,
      alamat: alamat ?? this.alamat,
      gambar: gambar ?? this.gambar,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'namakuliner': namakuliner});
    result.addAll({'notelepon': notelepon});
    result.addAll({'alamat': alamat});
    result.addAll({'gambar': gambar});

    return result;
  }

  factory Kuliner.fromMap(Map<String, dynamic> map) {
    return Kuliner(
      namakuliner: map['namakuliner'] ?? '',
      notelepon: map['notelepon'] ?? '',
      alamat: map['alamat'] ?? '',
      gambar: map['gambar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Kuliner.fromJson(String source) =>
      Kuliner.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Kuliner(namakuliner: $namakuliner, notelepon: $notelepon, alamat: $alamat, gambar: $gambar)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Kuliner &&
        other.namakuliner == namakuliner &&
        other.notelepon == notelepon &&
        other.alamat == alamat &&
        other.gambar == gambar;
  }

  @override
  int get hashCode {
    return namakuliner.hashCode ^
        notelepon.hashCode ^
        alamat.hashCode ^
        gambar.hashCode;
  }
}
