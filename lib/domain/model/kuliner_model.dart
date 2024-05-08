// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Kuliner {
  String namakuliner;
  String notelepon;
  String alamat;
  String gambar;
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
    return <String, dynamic>{
      'namakuliner': namakuliner,
      'notelepon': notelepon,
      'alamat': alamat,
      'gambar': gambar,
    };
  }

  factory Kuliner.fromMap(Map<String, dynamic> map) {
    return Kuliner(
      namakuliner: map['namakuliner'] as String,
      notelepon: map['notelepon'] as String,
      alamat: map['alamat'] as String,
      gambar: map['gambar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Kuliner.fromJson(String source) =>
      Kuliner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Kuliner(namakuliner: $namakuliner, notelepon: $notelepon, alamat: $alamat, gambar: $gambar)';
  }

  @override
  bool operator ==(covariant Kuliner other) {
    if (identical(this, other)) return true;

    return other.namakuliner == namakuliner &&
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
