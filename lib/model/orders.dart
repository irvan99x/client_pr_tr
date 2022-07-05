import 'package:dashbord/model/service_requirements.dart';

class Orders {
  String id;
  String order;
  String file;
  String status;
  String keterangan;
  ServiceRequirements serviceRequirements;

  Orders(
      {this.id,
      this.order,
      this.file,
      this.status,
      this.keterangan,
      this.serviceRequirements});

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
        id: json['id'],
        order: json['order'],
        file: json['file'],
        status: json['status'],
        keterangan: json['keterangan'],
        serviceRequirements: json['pelayanan']);
  }
}
