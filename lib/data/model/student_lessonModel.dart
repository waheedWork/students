

class StudentLessonModel {
  String? id;
  String? studentId;
  String? studentName;
  String? lessonId;
  String? test;
  String? level;
  String? studentLessonNote;
  String? teacherLessonNote;
  String? late;
  String? studentLessonIsCome;
  String? stdLesDate;
  String? studentIsGet;

  StudentLessonModel(
      {this.id,
        this.studentId,
        this.studentName,
        this.lessonId,
        this.test,
        this.level,
        this.studentLessonNote,
        this.teacherLessonNote,
        this.late,
        this.studentLessonIsCome,
        this.stdLesDate,
        this.studentIsGet});

  StudentLessonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    studentName = json['student_name'];
    lessonId = json['lesson_id'];
    test = json['test'];
    level = json['level'];
    studentLessonNote = json['student_lesson_note'];
    teacherLessonNote = json['teacher_lesson_note'];
    late = json['late'];
    studentLessonIsCome = json['student_lesson_isCome'];
    stdLesDate = json['std_les_date'];
    studentIsGet = json['student_isGet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['student_id'] = studentId;
    data['student_name'] = studentName;
    data['lesson_id'] = lessonId;
    data['test'] = test;
    data['level'] = level;
    data['student_lesson_note'] = studentLessonNote;
    data['teacher_lesson_note'] = teacherLessonNote;
    data['late'] = late;
    data['student_lesson_isCome'] = studentLessonIsCome;
    data['std_les_date'] = stdLesDate;
    data['student_isGet'] = studentIsGet;
    return data;
  }
}