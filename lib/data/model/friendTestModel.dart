class FriendTestModel {
  String? studentId;
  String? studentName;
  String? test;
  String? lessonId;
  String? stdLesDate;

  FriendTestModel(
      {this.studentId,
        this.studentName,
        this.test,
        this.lessonId,
        this.stdLesDate});

  FriendTestModel.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    studentName = json['student_name'];
    test = json['test'];
    lessonId = json['lesson_id'];
    stdLesDate = json['std_les_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['student_name'] = studentName;
    data['test'] = test;
    data['lesson_id'] = lessonId;
    data['std_les_date'] = stdLesDate;
    return data;
  }
}