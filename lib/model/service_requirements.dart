class ServiceRequirements {
  String id;
  String serviceType;
  String keterangan;

  ServiceRequirements({
    this.id,
    this.serviceType,
    this.keterangan,
  });

  factory ServiceRequirements.fromJson(Map<String, dynamic> json) {
    return ServiceRequirements(
        id: json['id'],
        serviceType: json['jenis_pelayanan'],
        keterangan: json['keterangan']);
  }
}
