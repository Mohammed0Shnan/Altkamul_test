class QuestionsResponse {
  late String statusCode;
  late String msg;
  late List<Data> data;

  QuestionsResponse.fromJson(Map<String, dynamic> json) {

    statusCode = json['status_code'] == null? '':'';
    msg = json['msg'] == null ? '':'';
    // The second section of the condition when there are no services
    if (json['items'] != null && !(json['items'] is String)) {
      data =  <Data>[];
      json['items'].forEach((v) {
        data.add(new Data.fromJson(v));
      });

    } else {
      data = [];
    }
  }

}

class Data{
  late int question_id ;
  late String title;
  late bool is_answered;
  late int view_count;
  late int answer_count;
  late int score;
  late DateTime creation_date;
  Data.fromJson(Map<String, dynamic> data) {

    this.question_id = data['question_id'];
    this.title = data['title'];
    this.is_answered = data['is_answered'] ;
    this.view_count =  data['view_count'] ;
    this.answer_count =  data['answer_count'] ;
    this.score =  data['score'] ;
    this.creation_date=DateTime.parse( data['creation_date'].toString() ) ;

  }
}









