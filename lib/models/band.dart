
class Band {

  String id;
  String name;
  String votes;
  String ranking;

  Band({
    required this.id,
    required this.name,
    required this.votes,
    required this.ranking
  });

  factory Band.fromMap(Map<String, dynamic> obj)
    => Band(
        id: obj['id'],
        name: obj['name'],
        votes: obj['votes'],
        ranking: obj['ranking'],
      );
      
}