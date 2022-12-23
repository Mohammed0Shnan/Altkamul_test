class QuestionDetailResponse {
  late int question_id ;
  late String title;
  late bool is_answered;
  late int view_count;
  late int answer_count;
  late int score;
  late DateTime creation_date;
  late String link;
  late List<String> tags;
  QuestionDetailResponse();

  QuestionDetailResponse.fromJson(Map<String, dynamic> data) {
    this.question_id = data['question_id'];
    this.title =  data['title'] ;
    this.is_answered = data['is_answered'] ;
    this.view_count =  data['view_count'] ;
    this.answer_count =  data['answer_count'] ;
    this.score =  data['score'] ;
    this.creation_date=DateTime.parse( data['creation_date'].toString() ) ;
    this.link =  data['link'] ;
    this.tags =  data['tags'].cast<String>();
  }
}
