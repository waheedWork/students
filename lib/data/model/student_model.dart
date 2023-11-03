class StudentModel {
  String? studentId;
  String? studentName;
  String? studentPassword;
  String? studentCreate;
  String? studentPhone;
  String? studentParentName;
  String? studentParentPhone;
  String? studentBornDate;
  String? studentType;
  String? studentBay;

  StudentModel(
      {this.studentId,
      this.studentName,
      this.studentPassword,
      this.studentCreate,
      this.studentPhone,
      this.studentParentName,
      this.studentParentPhone,
      this.studentBornDate,
      this.studentType,
      this.studentBay});

  StudentModel.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    studentName = json['student_name'];
    studentPassword = json['student_password'];
    studentCreate = json['student_create'];
    studentPhone = json['student_phone'];
    studentParentName = json['student_parent_name'];
    studentParentPhone = json['student_parent_phone'];
    studentBornDate = json['student_born_date'];
    studentType = json['student_type'];
    studentBay = json['student_bay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['student_name'] = studentName;
    data['student_password'] = studentPassword;
    data['student_create'] = studentCreate;
    data['student_phone'] = studentPhone;
    data['student_parent_name'] = studentParentName;
    data['student_parent_phone'] = studentParentPhone;
    data['student_born_date'] = studentBornDate;
    data['student_type'] = studentType;
    data['student_bay'] = studentBay;
    return data;
  }
}
