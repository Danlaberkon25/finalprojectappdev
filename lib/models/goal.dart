class Goal {
  String id;
  String goalName;
  int goalAmount;
  int goalProgress;
  String currency;
  List<Map<String,dynamic>> goalHistory;
  bool isArchived;


  Goal({
    required this.id,
    required this.goalName,
    required this.goalAmount,
    required this.goalProgress,
    required this.currency,
    required this.goalHistory,
    required this.isArchived,
});

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json['id'],
      goalName: json['goalName'],
      goalAmount: json['goalAmount'],
      goalProgress: json['goalProgress'],
      currency: json['currency'],
      goalHistory: List<Map<String, dynamic>>.from(
        (json['goalHistory'] ?? []).map(
              (e) => Map<String, dynamic>.from(e),
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
        'goalProgress': goalProgress,
        'currency': currency,
        'goalHistory' : goalHistory,
        'isArchived': isArchived,
      };
    }
  }