class Goal {
  String id;
  String goalName;
  int goalAmount;
  int goalRemaining;
  int goalProgress;
  String note;
  String currency;
  List<Map<String,String>> goalHistory;
  bool isArchived;


  Goal({
    required this.id,
    required this.goalName,
    required this.goalAmount,
    required this.goalRemaining,
    required this.goalProgress,
    required this.note,
    required this.currency,
    required this.goalHistory,
    required this.isArchived,
});

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json['id'],
      goalName: json['goalName'],
      goalAmount: json['goalAmount'],
      goalRemaining: json['goalRemaining'],
      goalProgress: json['goalProgress'],
      note: json['note'],
      currency: json['currency'],
      goalHistory: List<Map<String, String>>.from(
        (json['goalHistory'] ?? []).map(
              (e) => Map<String, String>.from(e),
        ),
      ),
      isArchived: json['isArchived'],
    );
  }

    Map<String, dynamic> toJson(){
      return{
        'id': id,
        'goalName': goalName,
        'goalAmount': goalAmount,
        'goalRemaining': goalRemaining,
        'goalProgress': goalProgress,
        'note': note,
        'currency': currency,
        'goalHistory' : goalHistory,
        'isArchived': isArchived,
      };
    }
  }