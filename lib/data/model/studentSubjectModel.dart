class StudentSubjectModel {
  String? teacherId;
  String? teacherName;
  String? teacherPassword;
  String? teacherCreate;
  String? subjectId;
  String? teacherPhone;
  String? subjectName;
  String? subjectMark;
  String? id;
  String? studentId;
  String? lessonId;
  String? test;
  String? level;
  String? studentLessonNote;
  String? teacherLessonNote;
  String? late;
  String? studentLessonIsCome;
  String? stdLesDate;
  String? studentIsGet;
  String? lessonDate;
  String? lessonNote;
  String? lessonDay;
  String? lessonTime;
  String? lessonPeriod;

  StudentSubjectModel(
      {this.teacherId,
        this.teacherName,
        this.teacherPassword,
        this.teacherCreate,
        this.subjectId,
        this.teacherPhone,
        this.subjectName,
        this.subjectMark,
        this.id,
        this.studentId,
        this.lessonId,
        this.test,
        this.level,
        this.studentLessonNote,
        this.teacherLessonNote,
        this.late,
        this.studentLessonIsCome,
        this.stdLesDate,
        this.studentIsGet,
        this.lessonDate,
        this.lessonNote,
        this.lessonDay,
        this.lessonTime,
        this.lessonPeriod});

  StudentSubjectModel.fromJson(Map<String, dynamic> json) {
    teacherId = json['teacher_id'];
    teacherName = json['teacher_name'];
    teacherPassword = json['teacher_password'];
    teacherCreate = json['teacher_create'];
    subjectId = json['subject_id'];
    teacherPhone = json['teacher_phone'];
    subjectName = json['subject_name'];
    subjectMark = json['subject_mark'];
    id = json['id'];
    studentId = json['student_id'];
    lessonId = json['lesson_id'];
    test = json['test'];
    level = json['level'];
    studentLessonNote = json['student_lesson_note'];
    teacherLessonNote = json['teacher_lesson_note'];
    late = json['late'];
    studentLessonIsCome = json['student_lesson_isCome'];
    stdLesDate = json['std_les_date'];
    studentIsGet = json['student_isGet'];
    lessonDate = json['lesson_date'];
    lessonNote = json['lesson_note'];
    lessonDay = json['lesson_day'];
    lessonTime = json['lesson_time'];
    lessonPeriod = json['lesson_period'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['teacher_id'] = teacherId;
    data['teacher_name'] = teacherName;
    data['teacher_password'] = teacherPassword;
    data['teacher_create'] = teacherCreate;
    data['subject_id'] = subjectId;
    data['teacher_phone'] = teacherPhone;
    data['subject_name'] = subjectName;
    data['subject_mark'] = subjectMark;
    data['id'] = id;
    data['student_id'] = studentId;
    data['lesson_id'] = lessonId;
    data['test'] = test;
    data['level'] = level;
    data['student_lesson_note'] = studentLessonNote;
    data['teacher_lesson_note'] = teacherLessonNote;
    data['late'] = late;
    data['student_lesson_isCome'] = studentLessonIsCome;
    data['std_les_date'] = stdLesDate;
    data['student_isGet'] = studentIsGet;
    data['lesson_date'] = lessonDate;
    data['lesson_note'] = lessonNote;
    data['lesson_day'] = lessonDay;
    data['lesson_time'] = lessonTime;
    data['lesson_period'] = lessonPeriod;
    return data;
  }
}