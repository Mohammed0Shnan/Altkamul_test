class QuestionModel{
  late int id ;
  late String title;
  late bool is_answered;
  late int view_count;
  late int answer_count;
  late int score;
  late DateTime creation_date;
  late String link;
  late List<String> tags;
  QuestionModel({required this.id , required this.title , required this.is_answered,required this.creation_date, required this.answer_count , required this.score, required this.view_count });


  QuestionModel.fromMap(Map<String, dynamic> item):
        id=item["id"],
        title= item["title"],
        is_answered= item["is_answered"],
        view_count= item["view_count"],
        answer_count= item["answer_count"],
        score= item["score"];

  Map<String, Object> toMap(){
    return {'id':id,
      'title': title,
      'is_answered':is_answered,
      'view_count':view_count,
      'answer_count':answer_count,
      'score':score
    };
  }
}



