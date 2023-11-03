
class LessonModel {
  String? lessonId;
  String? lessonDate;
  String? lessonNote;
  String? teacherId;
  String? lessonDay;
  String? lessonTime;
  String? lessonPeriod;

  LessonModel(
      {this.lessonId,
        this.lessonDate,
        this.lessonNote,
        this.teacherId,
        this.lessonDay,
        this.lessonTime,
        this.lessonPeriod});

  LessonModel.fromJson(Map<String, dynamic> json) {
    lessonId = json['lesson_id'];
    lessonDate = json['lesson_date'];
    lessonNote = json['lesson_note'];
    teacherId = json['teacher_id'];
    lessonDay = json['lesson_day'];
    lessonTime = json['lesson_time'];
    lessonPeriod = json['lesson_period'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lesson_id'] = lessonId;
    data['lesson_date'] = lessonDate;
    data['lesson_note'] = lessonNote;
    data['teacher_id'] = teacherId;
    data['lesson_day'] = lessonDay;
    data['lesson_time'] = lessonTime;
    data['lesson_period'] = lessonPeriod;
    return data;
  }
}