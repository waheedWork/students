class BayModel {
  String? bayId;
  String? bayDate;
  String? quantity;
  String? studentId;
  String? studentBay;

  BayModel(
      {this.bayId,
        this.bayDate,
        this.quantity,
        this.studentId,
        this.studentBay});

  BayModel.fromJson(Map<String, dynamic> json) {
    bayId = json['bay_id'];
    bayDate = json['bay_date'];
    quantity = json['quantity'];
    studentId = json['student_id'];
    studentBay = json['student_bay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bay_id'] = bayId;
    data['bay_date'] = bayDate;
    data['quantity'] = quantity;
    data['student_id'] = studentId;
    data['student_bay'] = studentBay;
    return data;
  }
}